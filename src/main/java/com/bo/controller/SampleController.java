package com.bo.controller;

import lombok.extern.slf4j.Slf4j;
import org.bo.domain.SampleDTO;
import org.bo.domain.SampleDTOList;
import org.bo.domain.TodoDTO;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;


@RestController
@Controller
@RequestMapping("/sample/*")
@Slf4j
public class SampleController {

    @InitBinder
    public void initBinder(WebDataBinder binder){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
    }

    @RequestMapping("")
    public void basic(){
        log.info("basic......................");
    }

    @RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
    public void basicGet(){
        log.info("basic get...............");
    }
    @GetMapping ("/basicOnlyGet")
    public void basicGet2(){
        log.info("basic get only get...........");
    }

    @GetMapping("/ex01")
    public String ex01(SampleDTO dto){
        log.info(""+dto);
        return "ex01";
    }
    @GetMapping("/ex02")
    public String ex02(@RequestParam("name") String name, @RequestParam("age") int age){
        log.info("name"+ name);
        log.info("age"+age);
        return "ex02";
    }
    @GetMapping("/ex02List")
    public String ex02List(@RequestParam("ids") ArrayList<String> ids){
        log.info("ids : " + ids);
        return "ex02List";
    }
    @GetMapping("/ex02Array")
    public String ex02Array(@RequestParam("ids") String[] ids){
        log.info("array ids : " + Arrays.toString(ids));
        return "ex02Array";
    }
    @GetMapping("/ex02Bean")
    public String ex02Bean(SampleDTOList list){
        log.info("list dtos" + list);
        return "ex02Bean";
    }

    @GetMapping("/ex03")
    public String ex03(TodoDTO todo){
        log.info("todo : " + todo);
        return "ex03";
    }
    @GetMapping("/ex04")
    public String ex04(SampleDTO dto, @ModelAttribute("page") int page){
        log.info("dto : " + dto);
        log.info("page : "+ page);

        return "/sample/ex04";
    }

    //???????????? json???????????? ????????? ???????????? ???????????? ?????????. jackson-databind(in pom.xml)
    @GetMapping("/ex06")
    public @ResponseBody SampleDTO ex06(){
        log.info("/ex06............");
        SampleDTO dto = new SampleDTO();
        dto.setAge(10);
        dto.setName("?????????");

        return dto;
    }

    //ResponseEntity??? HttpHeaders ????????? ?????? ?????? ??? ??? ??????, ?????? ????????? ????????? Http ?????? ???????????? ???????????? ?????? ???????????????.
    @GetMapping("/ex07")
    public ResponseEntity<String> ex07(){
        log.info("/ex07............");

        //{"name" : "?????????"}
        String msg = "{\"name\" : \"?????????\"}";

        HttpHeaders header = new HttpHeaders();
        header.add("Content-Type", "application/json;charset=UTF-8");
        return new ResponseEntity<>(msg, header, HttpStatus.INTERNAL_SERVER_ERROR);
        //ResponseEntity(????????? ?????????, HttpHeaders ????????? ?????? ??????, ??? ????????? ???????????? ??????)
    }

    //?????? ???????????? ?????? ?????????
    @RequestMapping(value = "/exUpload", method = {RequestMethod.POST, RequestMethod.GET})
    public void exUpload(){
        log.info("/exUpload..................");
    }

    @PostMapping("/exUploadPost")
    public void exUploadPost(ArrayList<MultipartFile> files){
        files.forEach(file -> {
            log.info("------------------------");
            log.info("name : " + file.getOriginalFilename());
            log.info("size : " + file.getSize());
        });
    }


}

