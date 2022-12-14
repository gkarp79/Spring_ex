package com.bo.controller;


import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.javassist.tools.rmi.Sample;
import org.bo.domain.SampleVO;
import org.bo.domain.Ticket;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import static org.springframework.http.MediaType.*;

@RestController
@Log4j2
@RequestMapping("/sample")
public class RestSampleController {

    @GetMapping(value="/getText", produces = "text/plain; charset=UTF-8")
    public String getText(){
        log.info("MiIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
        return "안녕하세요";
    }


    @GetMapping(value="/getSample", produces = {APPLICATION_XML_VALUE, APPLICATION_JSON_VALUE})
    public SampleVO getSample(){

        return new SampleVO(112,"스타", "로드");
    }

    @GetMapping(value="/getSample2", produces = {MediaType.APPLICATION_XML_VALUE})
    public SampleVO getSample2(){
        return new SampleVO(113, "로켓", "라쿤");
    }
    @GetMapping(value = "/getList")
    public List<SampleVO> getList(){
        return IntStream.range(1,10).mapToObj(i -> new SampleVO(i,i+"First",i+"Last"))
                .collect(Collectors.toList());
    }

    @GetMapping(value = "/getMap")
    public Map<String, SampleVO> getMap(){
        Map<String, SampleVO> map = new HashMap<>();
        map.put("First",new SampleVO(111,"그루트","주니어"));
        return map;
    }

    @GetMapping(value="/check", params = {"height", "weight"})
    public ResponseEntity<SampleVO> check(Double height, Double weight){
        SampleVO vo = new SampleVO(0,""+height,""+weight);
        ResponseEntity<SampleVO> result = null;

        if(height < 150){
            result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
        }else{
            result = ResponseEntity.status(HttpStatus.OK).body(vo);
        }

        return result;
    }

    @GetMapping("/product/{cat}/{pid}")
    public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid){
        return new String[] {"category : " + cat, "productid : "+pid};
    }

    @PostMapping("/ticket")
    public Ticket convert(@RequestBody Ticket ticket){
        log.info("convert........... ticket : " + ticket);

        return ticket;
    }
    
}
