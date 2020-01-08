package com.unichain.market.admin.application.controller;

import com.alibaba.fastjson.JSONObject;
import com.unichain.framework.mvc.exception.BusinessException;
import com.unichain.market.biz.utils.BeanTransferUtils;
import com.unichain.user.model.auth.SessionContext;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;

import javax.servlet.http.HttpServletRequest;

/**
 * @Auther: zorro
 * @Date: 2018/12/31 00:30
 * @Description:
 */
public abstract class TokenController {

    private static final Logger LOGGER = LoggerFactory.getLogger(TokenController.class);

    @Autowired
    RedisTemplate redisTemplate;

    Object getToken(HttpServletRequest httpServletRequest,Object object){
        String token = httpServletRequest.getHeader("Token");
        if(StringUtils.isNotBlank(token)){
            Object val= redisTemplate.opsForValue().get(token);
            if(val != null){
                SessionContext sessionContext = new SessionContext();
                try {
                    JSONObject jsonObject= (JSONObject) val;
                    sessionContext.setValid(jsonObject.getBoolean("valid"));
                    sessionContext.setAccountId(jsonObject.getLong("accountId"));
                    sessionContext.setExpireTime(jsonObject.getInteger("expireTime"));
                    sessionContext.setAccountName(jsonObject.getString("accountName"));
                    sessionContext.setAppName(jsonObject.getString("appName"));
                    sessionContext.setUserId(jsonObject.getLong("userId"));
                    sessionContext.setToken(jsonObject.getString("token"));
                }catch (Exception e){
                    LOGGER.warn("order service TokenController exception",e);
                    sessionContext = (SessionContext) val;
                }
                return BeanTransferUtils.SessionContextToBaseInfo(sessionContext,object);
            }
        }
        throw new BusinessException("100001","TOKEN错误或为空");
    }
}
