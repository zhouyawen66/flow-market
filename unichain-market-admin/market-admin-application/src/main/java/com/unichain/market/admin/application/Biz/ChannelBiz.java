package com.unichain.market.admin.application.Biz;

import com.unichain.market.model.page.UserInfoPage;
import com.unichain.market.model.req.ChannelDto;
import com.unichain.market.model.req.UserAccountDto;
import com.unichain.market.model.resp.ChannelVo;
import com.unichain.market.model.resp.Tendency;

import java.util.List;

public interface ChannelBiz {

    /**
     * 获得渠道商uv和注册信息
     * @param channelDto
     * @return
     */
    ChannelVo getChannelPvAndReg(ChannelDto channelDto);

    /**
     * 获得渠道商趋势图
     * @param channelDto
     * @return
     */
    List<Tendency> getTendency(ChannelDto channelDto);

    /**
     * 获取渠道商推送用户账户信息
     * @param userAccountDto
     * @return
     */
    UserInfoPage getUserRegInfo(UserAccountDto userAccountDto);

    /**
     * 获取注册App推送用户账户信息
     * @param userAccountDto
     * @return
     */
    UserInfoPage getUserRegApp(UserAccountDto userAccountDto);
}
