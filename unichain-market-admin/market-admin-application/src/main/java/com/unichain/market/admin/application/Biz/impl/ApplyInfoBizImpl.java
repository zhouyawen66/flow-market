package com.unichain.market.admin.application.Biz.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.unichain.framework.mvc.exception.BusinessException;
import com.unichain.market.admin.application.Biz.ApplyInfoBiz;
import com.unichain.market.api.ConfigClient;
import com.unichain.market.entity.*;
import com.unichain.market.model.*;
import com.unichain.market.model.resp.AppApplyinfoVo;
import com.unichain.market.model.resp.AppRegulationVo;
import com.unichain.market.model.resp.AppVo;
import com.unichain.market.model.resp.CompanyInforVo;
import com.unichain.market.service.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class ApplyInfoBizImpl implements ApplyInfoBiz {

    @Autowired
    HttpServletRequest httpServletRequest;

    @Autowired
    RedisTemplate redisTemplate;

    @Autowired
    AppService appService;

    @Autowired
    AppApplyinfoService appApplyinfoService;

    @Autowired
    AppRegulationService appRegulationService;

    @Autowired
    CompanyInforService companyInforService;

    @Autowired
    ConfigClient configClient;

    @Autowired
    ApplyRecordService applyRecordService;

    @Autowired
    PhotoConfigService photoConfigService;

    private static final Logger LOGGER = LoggerFactory.getLogger(ApplyInfoBizImpl.class);

    /**
     * 保存更新基本信息
     *
     * @param appModel
     */
    @Transactional
    @Override
    public void saveBasics(AppModel appModel) {
        LOGGER.info("ApplyInfoBizImpl saveBasics appModel is {}", JSON.toJSONString(appModel));
        if (StringUtils.isBlank(appModel.getName()) || appModel == null || appModel.getAccountId() == null) {
            throw new BusinessException("30000", "appModel," + FlowConsts.PARAM_ERROR);
        }
        try {
            List<App> listByApp = appService.findByAccountIdAndName(appModel);
            List<AppRegulation> list = appRegulationService.findByNameAndAccountId(appModel.getName(), appModel.getAccountId());
            if (appModel.getId() == null) {
                if (list.size() == 0 || list == null) {
                    if (listByApp == null || listByApp.size() == 0) {
                        appService.insertApp(appModel);
                        LOGGER.info("ApplyInfoBizImpl saveBasics 保存App信息成功！ is {}", JSON.toJSONString(appModel));
                    }
                    List<App> appList = appService.findByAccountIdAndName(appModel);
                    if (appList != null && appList.size() > 0) {
                        App app = appList.get(0);
                        appModel.setId(app.getId());
                        appRegulationService.insertAppRegulation(appModel);
                        LOGGER.info("ApplyInfoBizImpl saveAppRegulation 保存贷款条件信息成功！ is {}", JSON.toJSONString(appModel));
                        //存取背景banner
                        PhotoConfig photoConfig = new PhotoConfig();
                        photoConfig = savePhotoConfig(photoConfig);
                        photoConfig.setAppId(app.getId());
                        photoConfigService.insert(photoConfig);
                        LOGGER.info("ApplyInfoBizImpl saveAppRegulation 存背景banner成功! is {}", JSON.toJSONString(appModel));
                    }

                }
            } else {
                Long id = appModel.getId();
                List<App> appList = appService.findById(id);
                if (appList != null && appList.size() > 0) {
                    appService.updateAppById(appModel);
                    LOGGER.info("ApplyInfoBizImpl saveAppRegulation 更新App信息成功！ is {}", JSON.toJSONString(appModel));
                    List<AppRegulation> appRegulationList = appRegulationService.findAppRegulationById(appModel.getId());
                    if (appRegulationList != null && appRegulationList.size() > 0) {
                        appRegulationService.updateAppRegulationByApp(appModel);
                        LOGGER.info("ApplyInfoBizImpl saveAppRegulation 更新款条件信息成功！ is {}", JSON.toJSONString(appModel));
                    }
                }
            }
        } catch (BusinessException e) {
            LOGGER.error(" 500 saveBasics exception! Name = " + appModel.getName(), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
    }

    /**
     * 校验app名字同一用户是否重复添加
     *
     * @param appModel
     */
    @Override
    public void verifyName(AppModel appModel) {
        LOGGER.info("ApplyInfoBizImpl verifyName appModel is {}", JSON.toJSONString(appModel));
        if (StringUtils.isBlank(appModel.getName()) || appModel == null) {
            throw new BusinessException("30000", "Name," + FlowConsts.PARAM_ERROR);
        }
        List<AppRegulation> list = appRegulationService.findByNameAndAccountId(appModel.getName(), appModel.getAccountId());
        if (appModel.getId() == null) {
            if (list.size() != 0 && list != null) {
                LOGGER.info("ApplyInfoBizImpl verifyName App信息已经添加，请勿重复添加! is {}", JSON.toJSONString(appModel));
                throw new BusinessException("30000", "App信息已经添加，请勿重复添加!");
            }
        }

    }

    /**
     * 保存用户勾选信息
     *
     * @param appApplyinfoModelList
     */
    @Override
    public void saveModel(List<AppApplyinfoModel> appApplyinfoModelList) {
        LOGGER.info("ApplyInfoBizImpl saveModel appApplyinfoModel is {}", JSON.toJSONString(appApplyinfoModelList));
        if (appApplyinfoModelList.get(0).getName() == null) {
            throw new BusinessException("30000", "appApplyinfoModel," + FlowConsts.PARAM_ERROR);
        }
        try {
            List<App> appList = appService.findByName(appApplyinfoModelList.get(0).getName());
            if (appList != null && appList.size() > 0) {
                App app = appList.get(appList.size() - 1);
                if (appApplyinfoModelList != null && appApplyinfoModelList.size() > 0) {
                    for (AppApplyinfoModel appApplyinfoModel : appApplyinfoModelList) {
                        AppApplyinfo appApplyinfo = new AppApplyinfo();
                        appApplyinfo.setDisable(0);
                        appApplyinfo.setCode(appApplyinfoModel.getCode());
                        appApplyinfo.setGroupName(appApplyinfoModel.getGroupName());
                        appApplyinfo.setLabel(appApplyinfoModel.getLabel());
                        appApplyinfo.setAppId(app.getId());
                        appApplyinfoService.insert(appApplyinfo);
                        LOGGER.info("ApplyInfoBizImpl saveModel 保存用户勾选信息成功！ is {}", JSON.toJSONString(appApplyinfoModelList));
                    }
                }
            }
        } catch (BusinessException e) {
            LOGGER.error(" 500 saveModel exception! 保存用户勾选信息失败！ = " + appApplyinfoModelList, e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
    }

    /**
     * 保存贷款条件及更新
     *
     * @param appRegulationModel
     */
    @Override
    public void saveRegulation(AppRegulationModel appRegulationModel) {
        LOGGER.info("ApplyInfoBizImpl saveRegulation appNames is {}", JSON.toJSONString(appRegulationModel.getName()));
        if (StringUtils.isBlank(appRegulationModel.getName()) || appRegulationModel == null) {
            throw new BusinessException("30000", "appApplyinfoModel," + FlowConsts.PARAM_ERROR);
        }
        try {
            String token = httpServletRequest.getHeader("Token");
            // 获取到token在redis值
            JSONObject tokenNew = JSONObject.parseObject(redisTemplate.opsForValue().get(token) + "");
            if (tokenNew.get("accountId") != null) {
                Long accountId = Long.parseLong(tokenNew.get("accountId") + "");
                List<App> appList = appService.getByName(appRegulationModel.getName());
                List<AppRegulation> appRegulationList = appRegulationService.findByNameAndAccountId(appRegulationModel.getName(), accountId);
                if (appRegulationList == null || appRegulationList.size() == 0) {
                    if (appList != null && appList.size() > 0) {
                        App app = appList.get(appList.size() - 1);
                        AppRegulation appRegulation = new AppRegulation();
                        appRegulation.setAppId(app.getId());
                        appRegulation.setName(appRegulationModel.getName());
                        appRegulation.setGroupName(appRegulationModel.getGroupName());
                        appRegulation.setGroupVal(appRegulationModel.getGroupVal().toString().trim());
                        System.out.println(appRegulation.getGroupVal().length());
                        appRegulation.setAppName(appRegulationModel.getAppName());
                        appRegulation.setAccountId(accountId);
                        appRegulationService.insert(appRegulation);
                        LOGGER.info("ApplyInfoBizImpl saveRegulation 保存贷款条件成功！ is {}", JSON.toJSONString(appRegulationModel.getName()));
                    }
                } else {
                    if (null != appRegulationModel.getAppId()) {
                        appRegulationService.updateAppRegulationById(appRegulationModel);
                        LOGGER.info("ApplyInfoBizImpl saveRegulation 保存贷款条件更新成功！ is {}", JSON.toJSONString(appRegulationModel.getName()));
                    } else {
                        throw new BusinessException("30000", "appId," + FlowConsts.PARAM_ERROR);
                    }
                }
            } else {
                throw new BusinessException("Token已过期");
            }
        } catch (BusinessException e) {
            LOGGER.error(" 500 saveRegulation exception! 保存贷款条件失败！ = " + appRegulationModel.getName(), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
    }

    /**
     * 保存公司企业信息
     *
     * @param companyInforModel
     */
    @Override
    public void saveCompanyInfor(CompanyInforModel companyInforModel) {
        LOGGER.info("ApplyInfoBizImpl saveCompanyInfor companyInforModel is {}", JSON.toJSONString(companyInforModel));
        if (companyInforModel.getAccountId() == null || companyInforModel == null || StringUtils.isBlank(companyInforModel.getAppName())) {
            throw new BusinessException("30000", "companyInforModel," + FlowConsts.PARAM_ERROR);
        }
        List<CompanyInfor> companyInfors = companyInforService.findByAccountIdAndAppName(companyInforModel);
        if (companyInfors == null || companyInfors.size() == 0) {
            CompanyInfor companyInfor = new CompanyInfor();
            BeanUtils.copyProperties(companyInforModel, companyInfor);
            companyInforService.insert(companyInfor);
            LOGGER.info("ApplyInfoBizImpl saveCompanyInfor 公司企业信息保存成功！ is {}", JSON.toJSONString(companyInforModel));
        } else {
            LOGGER.info("ApplyInfoBizImpl saveCompanyInfor 公司信息已添加，请勿重新添加! is {}", JSON.toJSONString(companyInforModel));
            throw new BusinessException("公司信息已添加，请勿重新添加,如有异常，请联系程序员小哥哥!");
        }
    }

    /**
     * 获取公司信息
     *
     * @param companyInforModel
     * @return
     */
    @Override
    public CompanyInforVo selectCompanyInfo(CompanyInforModel companyInforModel) {
        LOGGER.info("ApplyInfoBizImpl selectCompanyInfo companyInforModel is {}", JSON.toJSONString(companyInforModel));
        if (companyInforModel.getAccountId() == null || StringUtils.isBlank(companyInforModel.getAppName())) {
            throw new BusinessException("30000", "companyInforModel," + FlowConsts.PARAM_ERROR);
        }
        CompanyInforVo companyInforVo = new CompanyInforVo();
        try {
            List<CompanyInfor> companyInfors = companyInforService.findByAccountIdAndAppName(companyInforModel);
            if (companyInfors != null && companyInfors.size() > 0) {
                CompanyInfor companyInfor = companyInfors.get(0);
                BeanUtils.copyProperties(companyInfor, companyInforVo);
                String logoUrlKey = companyInfor.getBusinessLicense();
                String BusinessLicense = appService.getPhoto(logoUrlKey);
                companyInforVo.setBusinessLicense(BusinessLicense);
                LOGGER.info("ApplyInfoBizImpl selectCompanyInfo 查询公司信息成功 is {}", JSON.toJSONString(companyInforModel));
                return companyInforVo;
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl selectCompanyInfo 查询公司信息失败 is {}", JSON.toJSONString(companyInforModel), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
        return companyInforVo;
    }

    /**
     * 保存和更新风控模型信息
     *
     * @param appApplyinfoModelList
     */
    @Override
    public void updateModel(List<AppApplyinfoModel> appApplyinfoModelList) {
        LOGGER.info("ApplyInfoBizImpl updateModel appApplyinfoModel is {}", JSON.toJSONString(appApplyinfoModelList));
        if (appApplyinfoModelList == null) {
            throw new BusinessException("30000", "appApplyinfoModel," + FlowConsts.PARAM_ERROR);
        }
        try {
            //开关
            if (appApplyinfoModelList.get(0).getModalFlag() != 0) {
                if (appApplyinfoModelList.get(0).getAppId() != null) {
                    Long appId = appApplyinfoModelList.get(0).getAppId();
                    List<AppApplyinfo> appApplyinfoList = appApplyinfoService.findAppApplyinfoById(appId);
                    //先删除
                    if (appApplyinfoList != null && appApplyinfoList.size() > 0) {
                        for (AppApplyinfo appApplyinfo : appApplyinfoList) {
                            appApplyinfoService.deletAppApplyinfo(appApplyinfo);
                        }
                    }
                    List<App> appList = appService.findById(appId);
                    if (appList != null && appList.size() > 0) {
                        //删除后新增
                        for (AppApplyinfoModel appApplyinfoModel : appApplyinfoModelList) {
                            AppApplyinfo appApplyinfo = new AppApplyinfo();
                            appApplyinfo.setAppId(appList.get(0).getId());
                            BeanUtils.copyProperties(appApplyinfoModel, appApplyinfo);
                            appApplyinfoService.insert(appApplyinfo);
                            LOGGER.info("ApplyInfoBizImpl updateModel 更新风控模型信息成功！ is {}", JSON.toJSONString(appApplyinfoModelList));
                        }
                    }
                } else {
                    //没有风控模型则新增
                    if (StringUtils.isNotBlank(appApplyinfoModelList.get(0).getName())) {
                        String name = appApplyinfoModelList.get(0).getName();
                        List<App> appList = appService.findByName(name);
                        if (appList != null && appList.size() > 0) {
                            App app = appList.get(appList.size() - 1);
                            for (AppApplyinfoModel appApplyinfoModel : appApplyinfoModelList) {
                                AppApplyinfo appApplyinfo = new AppApplyinfo();
                                BeanUtils.copyProperties(appApplyinfoModel, appApplyinfo);
                                appApplyinfo.setAppId(app.getId());
                                appApplyinfoService.insert(appApplyinfo);
                            }
                        }
                        LOGGER.info("ApplyInfoBizImpl updateModel 新增风控模型成功！ is {}", JSON.toJSONString(appApplyinfoModelList));
                    } else {
                        LOGGER.info("ApplyInfoBizImpl updateModel name为空！ is {}", JSON.toJSONString(appApplyinfoModelList));
                        throw new BusinessException("程序异常,name为空!");
                    }
                }
            } else {
                if (appApplyinfoModelList.get(0).getAppId() != null) {
                    Long appId = appApplyinfoModelList.get(0).getAppId();
                    List<AppApplyinfo> appApplyinfoList = appApplyinfoService.findAppApplyinfoById(appId);
                    //删除存在的风控模型
                    if (appApplyinfoList != null && appApplyinfoList.size() > 0) {
                        for (AppApplyinfo appApplyinfo : appApplyinfoList) {
                            appApplyinfoService.deletAppApplyinfo(appApplyinfo);
                        }
                    }
                }
                LOGGER.info("ApplyInfoBizImpl updateModel 风控模型开关已开启！ is {}", JSON.toJSONString(appApplyinfoModelList));
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl updateModel 更新风控模型信息失败！ is {}", JSON.toJSONString(appApplyinfoModelList));
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
    }

    /**
     * 查询App信息
     *
     * @param baseInfo
     * @return
     */
    @Override
    public List<AppVo> selectUserAppInfo(BaseInfo baseInfo) {
        LOGGER.info("ApplyInfoBizImpl selectUserAppInfo accountId is {}", JSON.toJSONString(baseInfo.getAccountId()));
        if (baseInfo.getAccountId() == null) {
            throw new BusinessException("30000", "accountId," + FlowConsts.PARAM_ERROR);
        }
        List<AppVo> appVoList = new ArrayList<>();
        try {
            List<AppRegulation> appRegulationList = appRegulationService.findByAccountId(baseInfo.getAccountId());
            if (appRegulationList != null && appRegulationList.size() > 0) {
                Set<AppRegulation> appRegulations = new HashSet<>();
                for (AppRegulation appRegulation : appRegulationList) {
                    appRegulations.add(appRegulation);
                }
                for (AppRegulation appRegulation : appRegulations) {
                    Long appId = appRegulation.getAppId();
                    List<App> appList = appService.findById(appId);
                    if (appList != null && appList.size() > 0) {
                        for (App app : appList) {
                            AppVo appVo = new AppVo();
                            BeanUtils.copyProperties(app, appVo);
                            String logUrlKey = appVo.getIcon();
                            String newPhoto = appService.getPhoto(logUrlKey);
                            appVo.setIcon(newPhoto);
                            appVoList.add(appVo);
                        }
                        LOGGER.info("ApplyInfoBizImpl selectUserAppInfo 获取用户产品信息成功！ is {}", JSON.toJSONString(baseInfo.getAccountId()));
                    }
                }
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl selectUserAppInfo 获取用户产品信息失败！ is {}", JSON.toJSONString(baseInfo.getAccountId()));
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
        return appVoList;
    }

    /**
     * 获得用户基本信息
     *
     * @param appModel
     * @return
     */
    @Override
    public AppVo getUserBasics(AppModel appModel) {
        LOGGER.info("ApplyInfoBizImpl getUserBasics Id is {}", JSON.toJSONString(appModel.getId()));
        if (appModel.getId() == null) {
            throw new BusinessException("30000", "Id," + FlowConsts.PARAM_ERROR);
        }
        AppVo appVo = new AppVo();
        try {
            List<App> appList = appService.findById(appModel.getId());
            List<AppRegulation> appRegulationList = appRegulationService.findAppRegulationById(appModel.getId());
            if (appList != null && appList.size() > 0) {
                if (appRegulationList != null && appRegulationList.size() > 0) {
                    App app = appList.get(0);
                    AppRegulation appRegulation = appRegulationList.get(0);
                    BeanUtils.copyProperties(app, appVo);
                    String logoUrlKey = appVo.getIcon();
                    String icon = appService.getPhoto(logoUrlKey);
                    appVo.setIcon(icon);
                    appVo.setGroupVal(appRegulation.getGroupVal());
                    return appVo;
                }
            }
            LOGGER.info("ApplyInfoBizImpl getUserBasics 获取用户产品信息成功！ is {}", JSON.toJSONString(appModel.getName()));
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl getUserBasics 获取用户产品信息失败！ is {}", JSON.toJSONString(appModel.getName()), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
        return appVo;
    }

    /**
     * 获取用户风控模型信息
     *
     * @param appApplyinfoModel
     * @return
     */
    @Override
    public List<AppApplyinfoVo> getUserModel(AppApplyinfoModel appApplyinfoModel) {
        LOGGER.info("ApplyInfoBizImpl getUserModel appApplyinfoModel  getAppId is {}", JSON.toJSONString(appApplyinfoModel.getAppId()));
        if (null == appApplyinfoModel.getAppId()) {
            throw new BusinessException("30000", "AppId," + FlowConsts.PARAM_ERROR);
        }
        List<AppApplyinfoVo> appApplyinfoVos = new ArrayList<>();
        try {
            List<AppApplyinfo> appApplyinfoList = appApplyinfoService.findAppApplyinfoById(appApplyinfoModel.getAppId());
            if (appApplyinfoList != null && appApplyinfoList.size() > 0) {
                for (AppApplyinfo appApplyinfo : appApplyinfoList) {
                    AppApplyinfoVo appApplyinfoVo = new AppApplyinfoVo();
                    BeanUtils.copyProperties(appApplyinfo, appApplyinfoVo);
                    appApplyinfoVos.add(appApplyinfoVo);
                }
                LOGGER.info("ApplyInfoBizImpl getUserModel 获取用户产品信息成功！ is {}", JSON.toJSONString(appApplyinfoModel.getAppId()));
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl getUserModel 获取用户产品信息失败！ is {}", JSON.toJSONString(appApplyinfoModel.getAppId()), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
        return appApplyinfoVos;
    }

    /**
     * 获得贷款条件
     *
     * @param appRegulationModel
     * @return
     */
    @Override
    public List<AppRegulationVo> getUserLoans(AppRegulationModel appRegulationModel) {
        LOGGER.info("ApplyInfoBizImpl getUserLoans appRegulationModel is {}", JSON.toJSONString(appRegulationModel.getAppId()));
        if (null == appRegulationModel.getAppId()) {
            throw new BusinessException("30000", "name," + FlowConsts.PARAM_ERROR);
        }
        List<AppRegulationVo> appRegulationVos = new ArrayList<>();
        try {
            List<AppRegulation> appRegulationList = appRegulationService.findAppRegulationById(appRegulationModel.getAppId());
            if (appRegulationList != null && appRegulationList.size() > 0) {
                for (AppRegulation appRegulation : appRegulationList) {
                    AppRegulationVo appApplyinfoVo = new AppRegulationVo();
                    BeanUtils.copyProperties(appRegulation, appApplyinfoVo);
                    appRegulationVos.add(appApplyinfoVo);
                }
                LOGGER.info("ApplyInfoBizImpl getUserLoans 获取贷款条件成功！ is {}", JSON.toJSONString(appRegulationModel.getAppId()));
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl getUserLoans 获取贷款条件失败！ is {}", JSON.toJSONString(appRegulationModel.getAppId()), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG);
        }
        return appRegulationVos;
    }

    /**
     * 更新app审核状态
     *
     * @param appModel
     */
    @Override
    public void updateAppStatus(AppModel appModel) {
        LOGGER.info("ApplyInfoBizImpl updateAppStatus appModel param is {}", JSON.toJSONString(appModel));
        if (null == appModel.getId() || StringUtils.isBlank(appModel.getAppName()) || StringUtils.isBlank(appModel.getName()) || null == appModel.getAuditStatus()) {
            throw new BusinessException("30000", "param," + FlowConsts.PARAM_ERROR);
        }
        try {
            List<App> appList = appService.findByIdAndNameAndAppName(appModel);
            if (appList != null && appList.size() > 0) {
                App app = appList.get(0);
                //更新app状态
                appService.updateAppStatus(appModel);
                LOGGER.info("ApplyInfoBizImpl updateAppStatus app审核状态更新成功! is {}", JSON.toJSONString(appModel.getName()));
            } else {
                LOGGER.info("ApplyInfoBizImpl updateAppStatus  未查询到该app信息 is {}", JSON.toJSONString(appModel.getName()));
                throw new BusinessException(FlowConsts.DB_ERROR_MSG);
            }
        } catch (BusinessException e) {
            LOGGER.error("ApplyInfoBizImpl updateAppStatus app审核状态更新失败！ is {}", JSON.toJSONString(appModel.getName()), e);
            throw new BusinessException(FlowConsts.DB_ERROR_MSG, e);
        }
    }

    private PhotoConfig savePhotoConfig(PhotoConfig config) {
        int num = new Random().nextInt(6);
        switch (num) {
            case 1:
                config.setPhotoUrl(PhotoConfigConsts.PHOTO_NUM1);
                break;
            case 2:
                config.setPhotoUrl(PhotoConfigConsts.PHOTO_NUM2);
                break;
            case 3:
                config.setPhotoUrl(PhotoConfigConsts.PHOTO_NUM3);
                break;
            case 4:
                config.setPhotoUrl(PhotoConfigConsts.PHOTO_NUM4);
                break;
            case 5:
                config.setPhotoUrl(PhotoConfigConsts.PHOTO_NUM5);
                break;
        }
        int money = new Random().nextInt(10);
        double moneyD = money * 0.1;
        if (0 == moneyD || 0.0 == moneyD) {
            moneyD = moneyD + 0.1;
        }
        config.setSurplusMoney(String.valueOf(moneyD));
        config.setAppName("txgj");
        return config;
    }

}
