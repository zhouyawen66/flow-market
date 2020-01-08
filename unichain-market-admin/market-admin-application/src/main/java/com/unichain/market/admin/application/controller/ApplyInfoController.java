package com.unichain.market.admin.application.controller;

import com.alibaba.fastjson.JSON;
import com.unichain.framework.mvc.annotation.Access;
import com.unichain.framework.mvc.controller.ResponseMessage;
import com.unichain.market.admin.application.Biz.ApplyInfoBiz;
import com.unichain.market.biz.utils.BeanTransferUtils;
import com.unichain.market.model.*;
import com.unichain.user.model.auth.SessionContext;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.unichain.framework.mvc.controller.ResponseMessage.error;

@RestController
@RequestMapping("/applyInfo")
public class ApplyInfoController extends TokenController {
    Logger logger = LoggerFactory.getLogger(ApplyInfoController.class);
    @Autowired
    private ApplyInfoBiz applyInfoBiz;

    @ApiOperation(value = "保存和更新产品基础信息")
    @PostMapping("/saveAppInfo")
    @Access(ignoreToken = true)
    public ResponseMessage insetApplyInfo(SessionContext sessionContext, @RequestBody AppModel appModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appModel);
        applyInfoBiz.saveBasics(appModel);
        return ResponseMessage.ok();

    }

    @ApiOperation(value = "保存引流商配置信息")
    @PostMapping("/saveModel")
    @Access(ignoreToken = true)
    public ResponseMessage insertModel(@RequestBody List<AppApplyinfoModel> appApplyinfoModel) throws Throwable {
        applyInfoBiz.saveModel(appApplyinfoModel);
        return ResponseMessage.ok();
    }

    @ApiOperation(value = "保存引流商选择或添加信息及更新")
    @PostMapping("/saveRegulation")
    @Access(ignoreToken = true)
    public ResponseMessage insertReg(SessionContext sessionContext, @RequestBody AppRegulationModel appRegulationModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appRegulationModel);
        applyInfoBiz.saveRegulation(appRegulationModel);
        return ResponseMessage.ok();
    }

    @ApiOperation(value = "保存公司企业信息")
    @PostMapping("/saveCompanyInfor")
    @Access(ignoreToken = true)
    public ResponseMessage insertModel(SessionContext sessionContext, @RequestBody CompanyInforModel companyInforModel) throws Throwable {
        try {
            BeanTransferUtils.SessionContextToBaseInfo(sessionContext, companyInforModel);
            applyInfoBiz.saveCompanyInfor(companyInforModel);
            return ResponseMessage.ok();
        } catch (Exception e) {
            logger.info("insertModel param:{}", JSON.toJSONString(companyInforModel), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation(value = "获取公司企业信息")
    @PostMapping("/getCompanyInfo")
    @Access(ignoreToken = true)
    public ResponseMessage getCompanyInfo(SessionContext sessionContext, @RequestBody CompanyInforModel companyInforModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, companyInforModel);
        return ResponseMessage.ok(applyInfoBiz.selectCompanyInfo(companyInforModel));
    }


    @ApiOperation(value = "更新引流商Model信息")
    @PostMapping("/updateModel")
    @Access(ignoreToken = true)
    public ResponseMessage updateModel(@RequestBody List<AppApplyinfoModel> appApplyinfoModel) throws Throwable {
        try {
            applyInfoBiz.updateModel(appApplyinfoModel);
            return ResponseMessage.ok();
        } catch (Exception e) {
            logger.info("updateModel param:{}", JSON.toJSONString(appApplyinfoModel), e);
            return error(e.getMessage());
        }

    }

    @ApiOperation(value = "获得用户添加后产品信息")
    @PostMapping("/getAppApplyinfo")
    @Access(ignoreToken = true)
    public ResponseMessage getAppApplyinfo(SessionContext sessionContext, @RequestBody BaseInfo baseInfo) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, baseInfo);
        return ResponseMessage.ok(applyInfoBiz.selectUserAppInfo(baseInfo));
    }

    @ApiOperation(value = "获得用户基本信息")
    @PostMapping("/getUserBasics")
    @Access(ignoreToken = true)
    public ResponseMessage getUserBasics(SessionContext sessionContext, @RequestBody AppModel appModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appModel);
        return ResponseMessage.ok(applyInfoBiz.getUserBasics(appModel));
    }

    @ApiOperation(value = "获取用户风控模型信息")
    @PostMapping("/getUserModel")
    @Access(ignoreToken = true)
    public ResponseMessage getUserModel(SessionContext sessionContext, @RequestBody AppApplyinfoModel appApplyinfoModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appApplyinfoModel);
        return ResponseMessage.ok(applyInfoBiz.getUserModel(appApplyinfoModel));
    }

    @ApiOperation(value = "获取用户贷款信息")
    @PostMapping("/getUserLoans")
    @Access(ignoreToken = true)
    public ResponseMessage getUserLoans(SessionContext sessionContext, @RequestBody AppRegulationModel appRegulationModel) throws Throwable {
        BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appRegulationModel);
        return ResponseMessage.ok(applyInfoBiz.getUserLoans(appRegulationModel));
    }

    @ApiOperation(value = "验证同一用户不可重复添加相同app")
    @PostMapping("/verifyName")
    @Access(ignoreToken = true)
    public ResponseMessage verifyName(SessionContext sessionContext, @RequestBody AppModel appModel) throws Throwable {
        try {
            BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appModel);
            applyInfoBiz.verifyName(appModel);
            return ResponseMessage.ok();
        } catch (Exception e) {
            logger.info("verifyName param:{}", JSON.toJSONString(appModel), e);
            return error(e.getMessage());
        }
    }

    @ApiOperation(value = "修改app审核状态")
    @PostMapping("/update/status")
    @Access(ignoreToken = true)
    public ResponseMessage updateAppStatus(SessionContext sessionContext, @RequestBody AppModel appModel) throws Throwable {
        try {
            BeanTransferUtils.SessionContextToBaseInfo(sessionContext, appModel);
            applyInfoBiz.updateAppStatus(appModel);
            return ResponseMessage.ok();
        } catch (Exception e) {
            logger.info("updateAppStatus param:{}", JSON.toJSONString(appModel), e);
            return error(e.getMessage());
        }
    }


}

