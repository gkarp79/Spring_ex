<%--
  Created by IntelliJ IDEA.
  User: samsung
  Date: 2022-10-17
  Time: 오후 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Board Read Page</div>
            <!-- /.panel-heading -->
            <div class="panel-body">

                <div class="form-group">
                    <label>Bno</label> <input class="form-control" name='bno' value='<c:out value="${board.bno}" />' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Text area</label>
                    <textarea class="form-control" rows="3" name='content' readonly="readonly">
              <c:out value="${board.content}" />
            </textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label> <input class="form-control" name='writer' value='<c:out value="${board.writer}" />' readonly="readonly">
                </div>
                <button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
                <button data-oper="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>

                <form action="/board/modify" id="operForm" method="get">
                    <input type="hidden" name="bno" id="bno" value="<c:out value="${board.bno}" />">
                </form>

            </div>
            <!--  end panel-body -->

        </div>
        <!--  end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->
<div class="bigPictureWrapper">
    <div class="bigPicture">
    </div>
</div>
<style>
    .uploadResult {
        width: 100%;
        background-color: lightgray;
    }

    .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li {
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img {
        width: 100px;
    }

    .uploadResult ul li span{
        color: white;
    }

    .bigPictureWrapper{
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: lightgray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }

    .bigPicture{
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img{
        width: 600px;
    }
</style>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Files</div>
            <div class="panel-body">
                <div class="uploadResult">
                    <ul>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <%--        panel     --%>
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
            </div>

            <%--        panel heading   --%>
            <div class="panel-body">
                <ul class="chat">
                    <%--                start reply   --%>
                    <li class="left clearfix" data-rno="12">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2022-10-19 23:59</small>
                            </div>
                            <p>Good Job!</p>
                        </div>
                    </li>
                    <%--                e:reply   --%>
                </ul>
                <%--            e:ul   --%>
            </div>
            <%--        e:chat-panel   --%>
        </div>
    </div>
    <%--    e:row   --%>
</div>


<%@include file="../includes/footer.jsp"%>

<script src="/resources/js/reply.js"></script>
<script>
    $(document).ready(function (){
        (function (ev){
            var bno = '<c:out value="${board.bno}" />';
            $.getJSON("/board/getAttachList", {bno:bno}, function(arr){
                console.log(arr);
                var str = "";
                $(arr).each(function(i, attach){
                    if (attach.fileType){
                        var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName +
                            "' data-type='" + attach.fileType + "' ></div>";
                        str += "<img src='/display?fileName=" + fileCallPath + "'></div></li>";
                    }else{
                        str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName +
                            "' data-type='" + attach.fileType +"' > </div>";
                        str += "<span> "+attach.fileName + "</span><br/>";
                        str += "<img src='/resources/img/attach.png' >";
                        str += "</div></li>";
                    }
                    console.log("$(arr).each(): "+str);
                }); // e: $(arr).each()
                $(".uploadResult ul").html(str);
            }); //e: $.getJSON()
        })(); // e: function()
        $(".uploadResult").on("click", "li", function(ev){
            console.log("view image");

            var liObj = $(this);
            var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if(liObj.data("type")){
                showImage(path.replace(new RegExp(/\\/g), "/"));
            } else{
                //    download
                self.location = "/download?fileName="+path;
            }
        }); // e: $(".uploadResult").on()

        function showImage(fileCallPath){
            alert(fileCallPath);

            $(".bigPictureWrapper").css("display", "flex").show();
            $(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'>").animate({width: '100%', height: '100%'}, 1000);
        }

        $(".bigPictureWrapper").on("click", function (ev){
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
            setTimeout(function (ev){
                $(".bigPictureWrapper").hide();
            }, 1000); // e: setTimeout()
        }); // e: $(".bigPictureWrapper").on()
    }); // $.ready()
</script>
<script>
    $(document).ready(function (){
        console.log(replyService);

        var operForm = $("#operForm");
        $("button[data-oper='modify']").on("click", function(ev){
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function (ev){
            operForm.find("#bno").remove();
            operForm.attr("action","/board/list");
            operForm.submit();
        });
    });
</script>

<script>
    console.log("---------------------");
    console.log("JS TEST");

    var bnoValue = '<c:out value="${board.bno}" />';
    var replyUL = $(".chat");
    showList(1);
    function showList(page){
        console.log("showList()");
        replyService.getList({bno:bnoValue, page:page||1}, function (list){
            var str = "";
            // console.log("getList()");

            if(list == null || list.length == 0){
                // console.log("showList()-if");
                replyUL.html("");
                return;
            }

            for (var i = 0, len = list.length || 0; i < len; i++) {
                // console.log("showList()-for"+i);
                str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
                str += "    <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
                str += "        <small class='pull-right text-muted'>"+list[i].replyDate+"</small></div>";
                str += "        <p>"+list[i].reply+"</p></div></li>";
            }
            replyUL.html(str);
        }); //e:function
    } //e:showList

    //    for replyService add test
    //     replyService.add(
    //         {reply:"JS TEST", replyer:"tester", bno:bnoValue},
    //         function (result){
    //             alert("RESULT: "+result);
    //         }
    //     );

    // replyService.getList({bno:bnoValue, page:1}, function(list){
    //     for(var i = 0, len = list.length||0; i<len; i++){
    //         console.log(list[i]);
    //     }
    //     });

    // replyService.remove(4, function (count){
    //     console.log(count);
    //
    //     if(count === "success"){
    //         alert("REMOVED");
    //     }
    // }, function (err){
    //     alert("error...");
    // });

    // replyService.update({
    //     rno : 13,
    //     bno : bnoValue,
    //     reply : "Modified Reply"
    // }, function (result){
    //     alert("수정 완료");
    // });

    // replyService.get(10, function(data){
    //     console.log(data);
    // });
</script>

