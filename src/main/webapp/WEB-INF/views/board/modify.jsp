<%@ page import="org.bo.domain.BoardVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: PerTo
  Date: 2022-10-14
  Time: 오후 3:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%
    System.out.println(request.getAttribute("board"));
%>
<script type="text/javascript">
    $(document).ready(function () {
        var formObj = $("form");
        $('button').on("click", function (e) {
            e.preventDefault();

            var operation = $(this).data("oper");

            console.log(operation);

            if (operation === "remove") {
                formObj.attr("action", "/board/remove");
            } else if (operation === 'list') {
                formObj.attr("action", "/board/list").attr("method", "get");

                var pageNumTag = $("input[name='pageNum']").clone();
                var amountTag = $("input[name='amount']").clone();
                var keywordTag = $("input[name='keyword']").clone();
                var typeTag = $("input[name='type']").clone();

                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(keywordTag);
                formObj.append(typeTag);
            }else if(operation ==='modify'){
                console.log("submit clicked");

                var str="";

                $(".uploadResult ul li").each(function (i, obj){
                    var jobj = $(obj);

                    console.dir(jobj);
                    str+= "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                    str+= "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                    str+= "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                    str+= "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";

                });
                formObj.append(str).submit();
            }
            formObj.submit();
        })
    })
</script>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Modify Page</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board Modify Page
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                    <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                    <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="form-group">
                        <label>Bno</label><input class="form-control" name="bno" value='<c:out value="${board.bno}"/>'
                                                 readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>Title</label><input name="title" class="form-control"
                                                   value="<c:out value='${board.title}'/>">
                    </div>

                    <div class="form-group">
                        <label>Text area</label><textarea name="content" rows="3" class="form-control"><c:out
                            value="${board.content}"/></textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label><input class="form-control" name="writer"
                                                    value="<c:out value='${board.writer}'/>" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>RegDate</label>
                        <input name="regDate" class="form-control"
                               value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.regDate}'/>"
                               readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Update Date</label>
                        <input name="updateDate" class="form-control"
                               value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.updateDate}'/>"
                               readonly="readonly">
                    </div>
                    <sec:authentication property="principal" var="pinfo"/>
                    <sec:authorize access="isAuthenticated()">
                        <c:if test="${pinfo.username eq board.writer}">
                    <button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                    <button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                        </c:if>
                    </sec:authorize>
                    <button type="submit" data-oper="list" class="btn btn-info">List</button>

                </form>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->
</div>
<div class='bigPictureWrapper'>
    <div class='bigPicture'>
    </div>
</div>
<!-- /.row -->


<style>
    .uploadResult {
        width: 100%;
        background-color: gray;
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

    .uploadResult ul li span {
        color: white;
    }

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }

    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width: 600px;
    }

</style>


<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Files</div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name='uploadFile' multiple="multiple">
                </div>

                <div class='uploadResult'>
                    <ul>

                    </ul>
                </div>
            </div>
            <!--  end panel-body -->

        </div>
        <!--  end panel-body -->
    </div>
    <!-- end panel -->
</div>
<!-- /.row -->
<script>
    $(document).ready(function () {
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 5242880;

        function checkExtension(fileName, fileSize){
            if(fileSize >= maxSize){
                alert("파일 사이즈 초과");
                return false;
            }

            if(regex.test(fileName)){
                alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                return false;
            }
            return true;
        }


        var csrfHeaderName = "${_csrf.headerName}";
        var csrfTokenValue = "${_csrf.token}";
        $('input[type="file"]').change(function (e){
            var formData = new FormData();

            var inputFile = $("input[name='uploadFile']");

            var files = inputFile[0].files;

            for(var i = 0; i <files.length; i++){
                if(!checkExtension(files[i].name, files[i].size)){
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url:'/uploadAjaxAction',
                processData:false,
                contentType:false,
                beforeSend:function (xhr){
                    xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
                },
                data:formData,
                type:'POST',
                dataType:'json',
                success:function(result){
                    console.log(result);
                    showUploadResult(result)
                }
            });//e:$.ajax

        })
        function showUploadResult(uploadResultArr) {

            var uploadUL = $(".uploadResult ul");

            var str= "";

            $(uploadResultArr).each(function (i, obj){
                if(obj.image){
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+ obj.uuid + "_"+obj.fileName);
                    str += "<li data-path='"+obj.uploadPath+"'";
                    str += "data-uuid = '"+obj.uuid +"' data-filename='"+obj.fileName+"' data-type='"+ obj.image+"'><div>";
                    str += "<span> " + obj.fileName + "</span>";
                    str += "<button type = 'button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='display?fileName=" + fileCallPath+"'>";
                    str += "</div></li>";
                }else{
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/"+obj.uuid+"_"+obj.fileName);
                    var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                    str += "<li ";
                    str += "data-path='"+obj.uploadPath+"'";
                    str += "data-uuid = '"+obj.uuid +"' data-filename='"+obj.fileName+"' data-type='"+ obj.image+"'><div>";
                    str += "<span>" + obj.fileName + "</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/attach.png'>" + "</div></li>";

                }
                uploadUL.append(str);
                $(".uploadResult").on("click", "button", function (e){
                    console.log("delete file");

                    var targetFile = $(this).data("file");
                    var type = $(this).data("type");

                    var targetLi = $(this).closest("li");

                    $.ajax({
                        url:'/deleteFile',
                        data:{fileName: targetFile, type: type},
                        dataType: 'text',
                        type:'POST',
                        success:function (result){
                            alert(result);
                            targetLi.remove();
                        }
                    })
                })
            });

        }//e:function showUploadResult
        (function () {
            var bno = '${board.bno}';

            $.getJSON("/board/getAttachList", {bno: bno}, function (arr) {
                console.log(arr);

                var str = "";

                $(arr).each(function (i, attach) {
                    //image type
                    if (attach.fileType) {
                        var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_"+ attach.uuid + "_"+attach.fileName);
                        str += "<li data-path='"+attach.uploadPath+"'";
                        str += "data-uuid = '"+attach.uuid +"' data-filename='"+attach.fileName+"' data-type='"+ attach.image+"'><div>";
                        str += "<span> " + attach.fileName + "</span>";
                        str += "<button type = 'button' class='btn btn-warning btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'><i class='fa fa-times'></i></button><br>";
                        str += "<img src='display?fileName=" + fileCallPath+"'>";
                        str += "</div></li>";
                    }else{
                        var fileCallPath = encodeURIComponent(attach.uploadPath + "/"+attach.uuid+"_"+attach.fileName);
                        var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                        str += "<li ";
                        str += "data-path='"+attach.uploadPath+"'";
                        str += "data-uuid = '"+attach.uuid +"' data-filename='"+attach.fileName+"' data-type='"+ attach.image+"'><div>";
                        str += "<span>" + attach.fileName + "</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
                        str += "<img src='/resources/img/attach.png'>" + "</div></li>";
                    }
                });
                $(".uploadResult ul").html(str);
            })//e:getJson
        })();//e:(function ()

        $(".uploadResult").on("click", "button", function (e){
            console.log("delete file");

            if(confirm("Remove this file? ")){

                var targetLi = $(this).closest("li");
                targetLi.remove();

            }
        })
    });//e:$(document).ready(
</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>