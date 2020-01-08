package com.unichain.market.admin.application.Biz.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.unichain.framework.mvc.controller.ResponseMessage;
import com.unichain.framework.mvc.exception.BusinessException;
import com.unichain.framework.utils.DateTimeUtils;
import com.unichain.market.admin.application.Biz.ChannelBiz;
import com.unichain.market.admin.biz.DateUtils;
import com.unichain.market.api.UserClient;
import com.unichain.market.model.FlowConsts;
import com.unichain.market.model.page.UserInfoPage;
import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.UserAccountDto;
import com.unichain.market.model.resp.*;
import com.unichain.market.service.ApplicationRecordService;
import com.unichain.market.service.ApplyRecordService;
import com.unichain.user.entity.UserAccount;
import org.apache.commons.lang3.StringUtils;
import org.bouncycastle.math.Primes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map.Entry;

import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ChannelBizlmpl implements ChannelBiz {

    private static final Logger LOGGER = LoggerFactory.getLogger(ChannelBizlmpl.class);


    @Autowired
    ApplyRecordService applyRecordService;

    @Autowired
    ApplicationRecordService applicationRecordService;

    @Autowired
    UserClient userClient;

    /**
     * 获取渠道商注册量和uv
     *
     * @param channelDto
     * @returnchannelDto
     */
    @Override
    public ChannelVo getChannelPvAndReg(ChannelDto channelDto) {
        LOGGER.info("ApplyInfoBizImpl getChannelPvAndReg source is {}", JSON.toJSONString(channelDto.getSource()));
        if (StringUtils.isBlank(channelDto.getAppName()) || null == channelDto.getDay()) {
            throw new BusinessException("30000", "channelDto" + FlowConsts.PARAM_ERROR);
        }
        if (StringUtils.isBlank(channelDto.getSource())) {
            throw new BusinessException("30000", FlowConsts.SOURCE_ERROR);
        }
        setTime(channelDto);
        ChannelVo channelVo = new ChannelVo();
        try {
//            //注册人数
//            int regNum = applyRecordService.findBySource(channelDto);
            Map<String, Object> mapCount = new HashMap<>();
            mapCount.put("appName", channelDto.getAppName());
            mapCount.put("source", channelDto.getSource());
            ResponseMessage message = userClient.getUserCount(mapCount);
            int regNum = 0;
            if (200 == message.getStatus()) {
                ActivationRatioVo activationRatioVo = (ActivationRatioVo) message.getResult();
                regNum = activationRatioVo.getUserNum();
                channelVo.setUserFirstNum(activationRatioVo.getUserFirstNum());
            }
            //Uv数量
            int uv = 0;
//            List<Map> maps = applyRecordService.findByUvNum(channelDto);
            List<Map> maps = applicationRecordService.findRegAndUv(channelDto);
            if (maps != null && maps.size() > 0) {
                for (Map map : maps) {
                    int uvNum = Integer.parseInt(map.get("uv").toString());
                    uv = uvNum + uv;
                }
            }
            channelVo.setRegistration(regNum);
            channelVo.setUv(uv);
        } catch (BusinessException e) {
            LOGGER.error("getChannelPvAndReg exception,param is:{}", JSON.toJSONString(channelDto), e);
            throw new BusinessException(FlowConsts.PARAM_ERROR, e);
        }
        return channelVo;
    }

    /**
     * 获得趋势注册量和Uv统计数量
     *
     * @param channelDto
     * @return
     */
    @Override
    public List<Tendency> getTendency(ChannelDto channelDto) {
        LOGGER.info("ApplyInfoBizImpl getTendency source is {}", JSON.toJSONString(channelDto.getSource()));
        if (StringUtils.isBlank(channelDto.getSource()) || StringUtils.isBlank(channelDto.getAppName()) || null == channelDto.getDay()) {
            throw new BusinessException("30000", "channelDto" + FlowConsts.PARAM_ERROR);
        }
        List<Tendency> tendencies = new ArrayList<>();
        try {
            setTime(channelDto);
            List<Map> maps = applicationRecordService.findRegAndUv(channelDto);
            UserAccountDto dto = new UserAccountDto();
            dto.setSource(channelDto.getSource());
            dto.setAppName(channelDto.getAppName());
            ResponseMessage message = userClient.getUserRegCountWithDate(dto);
            List<String> abscissa = new ArrayList<>();
            List<String> Uvdata = new ArrayList<>();
            List<String> Regdata = new ArrayList<>();
            Tendency tendency = new Tendency();
            if (200 == message.getStatus()) {
                List<Map> mapUser = (List<Map>) message.getResult();
                for (Map map : mapUser) {
                    String reg = map.get("reg").toString();
                    Regdata.add(reg);
                    String ctime = map.get("ctime").toString().substring(6, 10);
                    ctime = ctime.replaceAll("-", "/");
                    abscissa.add(ctime);
                }
                int num = mapUser.size() - maps.size();
                if (0 < num) {
                    for (int i = 0; i < num; i++) {
                        Uvdata.add("0");
                    }
                }
            }
            List<UvAndRegAbscissaVo> uvAndRegAbscissaVos = new ArrayList<>();
            if (maps != null && maps.size() > 0) {
                for (Map map : maps) {
                    if (10002 == message.getStatus()) {
                        String ctime = map.get("ctime").toString().substring(6, 10);
                        ctime = ctime.replaceAll("-", "/");
                        abscissa.add(ctime);
                    }
                    String uv = map.get("uv").toString();
                    Uvdata.add(uv);
                }

                //插入横坐标
                tendency.setAbscissa(abscissa);
                UvAndRegAbscissaVo uvAndPvAbscissaVoUv = new UvAndRegAbscissaVo();
                UvAndRegAbscissaVo uvAndPvAbscissaVoReg = new UvAndRegAbscissaVo();
                //存在pv
                uvAndPvAbscissaVoReg.setName("注册量");
                uvAndPvAbscissaVoReg.setStack("总量" + uvAndPvAbscissaVoReg.getName());
                uvAndPvAbscissaVoReg.setType("line");
                uvAndPvAbscissaVoReg.setData(Regdata);
                uvAndRegAbscissaVos.add(uvAndPvAbscissaVoReg);
                //存在uv
                uvAndPvAbscissaVoUv.setName("UV");
                uvAndPvAbscissaVoUv.setStack("总量" + uvAndPvAbscissaVoUv.getName());
                uvAndPvAbscissaVoUv.setType("line");
                uvAndPvAbscissaVoUv.setData(Uvdata);
                uvAndRegAbscissaVos.add(uvAndPvAbscissaVoUv);
                tendency.setUvAndRegAbscissaVos(uvAndRegAbscissaVos);
                tendencies.add(tendency);
            }
        } catch (BusinessException e) {
            LOGGER.error("getTendency exception,param is:{}", JSON.toJSONString(channelDto), e);
            throw new BusinessException(FlowConsts.PARAM_ERROR, e);
        }
        return tendencies;
    }

    /**
     * 获得渠道商推送产品账户信息
     *
     * @param userAccountDto
     * @return
     */
    @Override
    public UserInfoPage getUserRegInfo(UserAccountDto userAccountDto) {
        LOGGER.info("getUserRegInfo start,param is:{}", JSON.toJSONString(userAccountDto));
        int pageNo = 1;
        int pageSize = 10;
        String appName = "";
        String source = "";
        if ("".equals(userAccountDto.getSource())) {
            LOGGER.error("getUserRegInfo exception,渠道商 source is:{}", JSON.toJSONString(userAccountDto.getSource()));
            throw new BusinessException(FlowConsts.PROGRAM_ERROR);
        }
        //参数校验
        if (null != userAccountDto) {
            Integer paramPageNo = userAccountDto.getPageNo();
            Integer paramPageSize = userAccountDto.getPageSize();
            if (null != userAccountDto.getSource()) {
                source = userAccountDto.getSource();
            }
            if (null != paramPageNo && paramPageNo > 0) {
                pageNo = paramPageNo;
            }
            if (null != paramPageSize && paramPageSize > 200) {
                pageSize = 200;
            } else if (null != paramPageSize && paramPageSize > 0) {
                pageSize = paramPageSize;
            }
        }
//        judgeParam(userAccountDto);
        appName = userAccountDto.getAppName();
        UserInfoPage userInfoPage = new UserInfoPage();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (StringUtils.isNotBlank(userAccountDto.getSource())) {
                source = userAccountDto.getSource();
                map.put("source", userAccountDto.getSource());
            }
            if (StringUtils.isBlank(appName)) {
                appName = "txgj";
            }
            map.put("appName", appName);
            int first = (pageNo - 1) * pageSize;
            int offSet = pageSize;
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("first", first);
            paramMap.put("offSet", offSet);
            paramMap.put("appName", appName);
            paramMap.put("source", source);
            ResponseMessage responseMessage = userClient.getUserAccount(paramMap);
            List<UserAccountVo> list = (List<UserAccountVo>) responseMessage.getResult();
            ResponseMessage message = userClient.getUserCount(paramMap);
            ActivationRatioVo activationRatioVo = (ActivationRatioVo) message.getResult();
            int count = activationRatioVo.getUserNum();
            //添加用户信息
            userInfoPage.setUserAccountVos(list);
            userInfoPage.setTotalCount(count);
        } catch (BusinessException e) {
            LOGGER.error("getUserRegInfo exception,param is:{}", JSON.toJSONString(userAccountDto), e);
            throw new BusinessException(FlowConsts.PARAM_ERROR, e);
        }
        return userInfoPage;
    }

    /**
     * 获得APP注册用户手机号码
     *
     * @param userAccountDto
     * @return
     */
    @Override
    public UserInfoPage getUserRegApp(UserAccountDto userAccountDto) {
        LOGGER.info("getUserRegInfo start,param is:{}", JSON.toJSONString(userAccountDto));
        int pageNo = 1;
        int pageSize = 10;
        String appName = "";
        String source = "";
        UserInfoPage userInfoPage = new UserInfoPage();
        if (null != userAccountDto) {
            Integer paramPageNo = userAccountDto.getPageNo();
            Integer paramPageSize = userAccountDto.getPageSize();
            if (null != userAccountDto.getSource()) {
                source = userAccountDto.getSource();
            }
            if (null != paramPageNo && paramPageNo > 0) {
                pageNo = paramPageNo;
            }
            if (null != paramPageSize && paramPageSize > 200) {
                pageSize = 200;
            } else if (null != paramPageSize && paramPageSize > 0) {
                pageSize = paramPageSize;
            }

        }
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (null != userAccountDto.getAppId() && userAccountDto.getAppId() != 0) {
                map.put("appId", userAccountDto.getAppId());
            } else {
                LOGGER.error("getUserRegApp appId 为空===>>>{}", JSON.toJSONString(userAccountDto));
                throw new BusinessException(FlowConsts.PARAM_ERROR);
            }
            if (StringUtils.isBlank(appName)) {
                appName = "txgj";
            }
            map.put("appName", appName);
            //获取App的accountId信息
            List<Map> maps = applyRecordService.findByAppId(userAccountDto);
            int totalCount = maps.size();
            int first = (pageNo - 1) * pageSize;
            int offSet = pageSize;
            List<UserAccountVo> userAccountVos = new ArrayList<>();
            for (Map mapNew : maps) {
                Long accountId = Long.parseLong(mapNew.get("accountId").toString());
                userAccountDto.setAccountId(accountId);
                ResponseMessage<UserAccountVo> message = userClient.getUserByAccountId(userAccountDto);
                if (200 == message.getStatus()) {
                    UserAccountVo userAccountVo = message.getResult();
                    if (null != userAccountVo) {
                        String phone = userAccountVo.getAccountName();
                        //手机号脱敏
                        String phoneNumber = phone.substring(0, 3) + "****" + phone.substring(7, phone.length());
                        userAccountVo.setAccountName(phoneNumber);
                    }
                    userAccountVos.add(userAccountVo);
                }
            }
            userInfoPage.setTotalCount(totalCount);
            userInfoPage.setUserAccountVos(userAccountVos);
        } catch (Exception e) {
            LOGGER.error("getUserRegApp error,param is：{}", JSON.toJSONString(userAccountDto), e);
            throw new BusinessException(FlowConsts.PROGRAM_ERROR, e);
        }
        return userInfoPage;
    }


    /**
     * 设置时间
     *
     * @param channelDto
     */
    private void setTime(ChannelDto channelDto) {
        if (!StringUtils.isEmpty(channelDto.getDay() + "") && channelDto.getDay() != -1) {
            channelDto.setCtime(DateUtils.calcDate(0 - channelDto.getDay()));
        }
        if (-1 == channelDto.getDay()) {
            channelDto.setCtime("");
        }
    }


    private String formateDateToStr(Date date, String pattern) {
        if (null == date) {
            date = new Date();
        }
        if (StringUtils.isBlank(pattern)) {
            pattern = "yyyy-MM-dd HH:mm:ss";
        }
        return new SimpleDateFormat(pattern).format(date);
    }
}
