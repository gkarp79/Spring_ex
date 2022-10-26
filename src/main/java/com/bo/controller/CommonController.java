package com.bo.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.Authenticator;

@Controller
@Log4j2
public class CommonController {
    @GetMapping("/accessError")
    public void accessDenied(Authenticator auth, Model model){
        log.info("access Denied : " + auth);

        model.addAttribute("msg", "Access Denied");
    }

    @GetMapping("/customLogin")
    public void loginInput(String error, String logout, Model model){
        log.info("error : "+error);
        log.info("logout : "+logout);

        if(error != null){
            model.addAttribute("error", "Login Error Check Your Account");

        }

        if(logout != null){
            model.addAttribute("logout", "Logout!!");
        }
    }

    @GetMapping("/customLogout")
    public void logoutGET(){
        log.info("custom logout");
    }
}


