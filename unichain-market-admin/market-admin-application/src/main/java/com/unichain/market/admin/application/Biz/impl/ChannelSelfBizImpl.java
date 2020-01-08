package com.unichain.market.admin.application.Biz.impl;

import com.alibaba.fastjson.JSON;
import com.unichain.framework.mvc.exception.BusinessException;
import com.unichain.market.admin.application.Biz.ChannelSelfBiz;
import com.unichain.market.admin.biz.DateUtils;
import com.unichain.market.model.FlowConsts;
import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.ChannelSelfDto;
import com.unichain.market.model.resp.ChannelSelfVo;
import com.unichain.market.model.resp.UvAndPvAbscissaVo;
import com.unichain.market.model.resp.XYPhoto;
import com.unichain.market.service.ApplicationRecordService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChannelSelfBizImpl implements ChannelSelfBiz {

    private static final Logger LOGGER = LoggerFactory.getLogger(ChannelBizlmpl.class);

    @Autowired
    private ApplicationRecordService applicationRecordService;

  /*  *//**
     * 获取统计的pv和uv总和
     * @param channelSelfDto
     * @return
     *//*
    @Override
    public ChannelSelfVo selectPvAndUv(ChannelSelfDto channelSelfDto) {
        LOGGER.info("ChannelSelfBizImpl selectPvAndUv appId is {}", JSON.toJSONString(channelSelfDto.getAppId()));
        if (StringUtils.isBlank(String.valueOf(channelSelfDto.getAppId()))) {
            throw new BusinessException("30000", "channelSelfDto" + FlowConsts.PARAM_ERROR);
        }
        int pv = 0;
        int uv = 0;
        List<Map> maps = applicationRecordService.selectPvAndUv(channelSelfDto);
        ChannelSelfVo vo = new ChannelSelfVo();
        if (null != maps && maps.size()>0){
            if (maps != null && maps.size() > 0) {
                Map map = maps.get(0);
                int pv1 = Integer.parseInt(map.get("pv").toString());
                int uv1 = Integer.parseInt(map.get("uv").toString());
                pv = pv1 + pv;
                uv = uv1 + uv;
                vo.setPv(pv);
                vo.setUv(uv);
            }
        }
        return vo;
    }
*/
    /**
     * 获取一段时间的pv和uv
     * @param channelSelfDto
     * @return
     */
    @Override
    public Map<String, Object> selectPvAndUvByCtime(ChannelSelfDto channelSelfDto) {
        if (!StringUtils.isEmpty(channelSelfDto.getDay() + "") && channelSelfDto.getDay() != -1) {
            channelSelfDto.setCtime(DateUtils.calcDate(0 - channelSelfDto.getDay()));
        }
        if (-1 == channelSelfDto.getDay()) {
            channelSelfDto.setCtime("");
        }
        int pv = 0;
        int uv = 0;
        List<Map> maps = applicationRecordService.selectPvAndUvByCtime(channelSelfDto);
        Map<String, Object> mapNew = new HashMap<String, Object>();
        if (maps != null && maps.size() > 0) {
            for (Map map : maps) {
                int pv1 = Integer.parseInt(map.get("pv").toString());
                int uv1 = Integer.parseInt(map.get("uv").toString());
                pv = pv1 + pv;
                uv = uv1 + uv;
            }
            mapNew.put("pv", pv);
            mapNew.put("uv", uv);
        }
        return mapNew;
    }

    /**
     * 查询uv和pv趋势图的数据
     * @param channelSelfDto
     * @return
     */
    @Override
    public List<XYPhoto> queryUvAndPvAbscissa(ChannelSelfDto channelSelfDto) {
        if (channelSelfDto != null && null != channelSelfDto.getDay() && channelSelfDto.getDay() != -1) {
            channelSelfDto.setCtime(DateUtils.calcDate(0 - channelSelfDto.getDay()));
        }
        if (-1 == channelSelfDto.getDay()) {
            channelSelfDto.setCtime("");
        }
        List<Map> maps = applicationRecordService.selectPvAndUvByCtime(channelSelfDto);
        List<XYPhoto> xyPhotos = new ArrayList<>();
        try {
            List<UvAndPvAbscissaVo> uvAndPvAbscissaVos = new ArrayList<>();
            if (maps != null && maps.size() > 0) {
                XYPhoto xyPhoto = new XYPhoto();
                //插入横坐标
                List<String> abscissa = new ArrayList<>();
                List<String> Uvdata = new ArrayList<>();
                List<String> Pvdata = new ArrayList<>();
                xyPhoto.setAbscissa(abscissa);
                for (Map map : maps) {
                    String ctime = map.get("ctime").toString().substring(6, 10);
                    ctime = ctime.replaceAll("-", "/");
                    abscissa.add(ctime);
                    String uv = map.get("uv").toString();
                    Uvdata.add(uv);
                    String pv = map.get("pv").toString();
                    Pvdata.add(pv);
                }
                UvAndPvAbscissaVo uvAndPvAbscissaVoUv = new UvAndPvAbscissaVo();
                UvAndPvAbscissaVo uvAndPvAbscissaVoPv = new UvAndPvAbscissaVo();
                //存在pv
                uvAndPvAbscissaVoPv.setName("PV");
                uvAndPvAbscissaVoPv.setStack("总量"+uvAndPvAbscissaVoPv.getName());
                uvAndPvAbscissaVoPv.setType("line");
                uvAndPvAbscissaVoPv.setData(Pvdata);
                uvAndPvAbscissaVos.add(uvAndPvAbscissaVoPv);
                //存在uv
                uvAndPvAbscissaVoUv.setName("UV");
                uvAndPvAbscissaVoUv.setStack("总量"+uvAndPvAbscissaVoUv.getName());
                uvAndPvAbscissaVoUv.setType("line");
                uvAndPvAbscissaVoUv.setData(Uvdata);
                uvAndPvAbscissaVos.add(uvAndPvAbscissaVoUv);
                xyPhoto.setUvAndPvAbscissaVo(uvAndPvAbscissaVos);
                xyPhotos.add(xyPhoto);
                return xyPhotos;
            }
        } catch (BusinessException e) {
            LOGGER.error("queryUvAndPvAbscissa exception,param is:{}", JSON.toJSONString(channelSelfDto), e);
            throw new BusinessException("服务器开小差请稍后再试");
        }
        return xyPhotos;
    }


}
