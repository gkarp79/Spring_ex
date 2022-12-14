package com.bo.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.bo.domain.Criteria;
import org.bo.domain.ReplyPageDTO;
import org.bo.domain.ReplyVO;
import org.bo.service.ReplyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;
import static org.springframework.http.MediaType.TEXT_PLAIN_VALUE;

@RequestMapping("/replies/")
@RestController
@Log4j2
@AllArgsConstructor
public class ReplyController {
    private ReplyService service;

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value="/new", consumes = APPLICATION_JSON_VALUE, produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody ReplyVO vo){
        log.info("ReplyVO : " + vo);
        int insertCount = service.register(vo);

        log.info("Reply Insert Count : " + insertCount);

        return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    @GetMapping(value = "/pages/{bno}/{page}",produces = {APPLICATION_JSON_VALUE})
    public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno){

        Criteria cri = new Criteria(page, 10);
        log.info("get Reply List bno : " + bno);

        log.info("cri" + cri);
        return new ResponseEntity<>(service.getListPage(cri,bno), HttpStatus.OK);
    }

    @GetMapping(value="/{rno}",produces = {APPLICATION_JSON_VALUE})
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
        log.info("get : " + rno);
        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
    }


    @PreAuthorize("principal.username == #vo.replyer")
    @DeleteMapping("/{rno}")
    public ResponseEntity<String> remove(@RequestBody ReplyVO vo,@PathVariable("rno") Long rno){
        log.info("remove : " + rno);
        log.info("replyer : " + vo.getReplyer());
        return service.remove(rno)==1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PreAuthorize("principal.username == #vo.replyer")
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value = "/{rno}", consumes = "application/json",produces = {TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
        log.info("rno : " + rno);
        log.info("modify : " + vo);

        return service.modify(vo) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }


}
