package com.unichain.market.admin.application.Biz;

import com.unichain.market.model.*;
import com.unichain.market.model.resp.AppApplyinfoVo;
import com.unichain.market.model.resp.AppRegulationVo;
import com.unichain.market.model.resp.AppVo;
import com.unichain.market.model.resp.CompanyInforVo;

import java.util.List;

public interface ApplyInfoBiz {

    void saveBasics(AppModel appModel);

    void verifyName(AppModel appModel);

    /**
     * 保存引流商选择或添加信息
     *
     * @param appApplyinfoModel
     */
    void saveModel(List<AppApplyinfoModel> appApplyinfoModel);

    /**
     * 保存和更新贷款条件
     *
     * @param appRegulationModel
     */
    void saveRegulation(AppRegulationModel appRegulationModel);

    void saveCompanyInfor(CompanyInforModel companyInforModel);

    CompanyInforVo selectCompanyInfo(CompanyInforModel companyInforModel);

    void updateModel(List<AppApplyinfoModel> appApplyinfoModel);

    List<AppVo> selectUserAppInfo(BaseInfo baseInfo);

    /**
     * 获得用户基本信息
     *
     * @param appModel
     * @return
     */
    AppVo getUserBasics(AppModel appModel);

    /**
     * 获取用户风控模型信息
     *
     * @param appApplyinfoModel
     * @return
     */
    List<AppApplyinfoVo> getUserModel(AppApplyinfoModel appApplyinfoModel);

    /**
     * 获得贷款条件
     */
    List<AppRegulationVo> getUserLoans(AppRegulationModel appRegulationModel);

    /**
     * 更新app审核状态
     * @param appModel
     */
    void updateAppStatus(AppModel appModel);
}
