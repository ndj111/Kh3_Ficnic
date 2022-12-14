<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/layout_header.jsp" %>
<script type="text/javascript">$("#header .navbar .nav-item:nth-child(7)").addClass("active");</script>


<c:set var="m" value="${modify}" />
<c:if test="${!empty m}">
	<c:set var="tag" value="/admin/board/board_modify_ok.do" />
	<c:set var="conid" value="${Cont.getBoard_id()}" />
	<c:set var="conname" value="${Cont.getBoard_name()}" />
	<c:set var="conskin" value="${Cont.getBoard_skin()}" />
	<c:set var="conLnum" value="${Cont.getBoard_list_num()}" />
	<c:set var="conPnum" value="${Cont.getBoard_page_num()}" />
	<c:set var="con_use_cate" value="${Cont.getBoard_use_category()}" />
	<c:set var="con_use_comm" value="${Cont.getBoard_use_comment()}" />
	<c:set var="con_use_sec" value="${Cont.getBoard_use_secret()}" />
	<c:set var="con_use_only_sec" value="${Cont.getBoard_use_only_secret()}" />
	<c:set var="con_link1" value="${Cont.getBoard_use_link1()}" />
	<c:set var="con_link2" value="${Cont.getBoard_use_link2()}" />
	<c:set var="con_file1" value="${Cont.getBoard_use_file1()}" />
	<c:set var="con_file2" value="${Cont.getBoard_use_file2()}" />
	<c:set var="con_file3" value="${Cont.getBoard_use_file3()}" />
	<c:set var="con_file4" value="${Cont.getBoard_use_file4()}" />
	<c:set var="con_lv_list" value="${Cont.getBoard_level_list()}" />
	<c:set var="con_lv_view" value="${Cont.getBoard_level_view()}" />
	<c:set var="con_lv_write" value="${Cont.getBoard_level_write()}" />
	<c:set var="con_lv_comm" value="${Cont.getBoard_level_comment()}" />
	<c:set var="con_lv_not" value="${Cont.getBoard_level_notice()}" />
	<c:set var="con_lv_mod" value="${Cont.getBoard_level_modify()}" />
	<c:set var="con_lv_del" value="${Cont.getBoard_level_delete()}" />
</c:if>

<c:if test="${empty m }">
	<c:set var="tag" value="/admin/board/board_write_ok.do"></c:set>
	<c:set var="conLnum" value="10" />
	<c:set var="conPnum" value="3" />
	<c:set var="con_lv_not" value="admin" />
	<c:set var="con_lv_mod" value="admin" />
	<c:set var="con_lv_del" value="admin" />
</c:if>



<div class="page-info row mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <h2>????????? <c:choose><c:when test="${!empty m}">??????</c:when><c:otherwise>??????</c:otherwise></c:choose></h2>
        <ol class="m-0 p-2">
        	<li>????????? ??????</li>
            <li><b>????????? <c:choose><c:when test="${!empty m}">??????</c:when><c:otherwise>??????</c:otherwise></c:choose></b></li>
        </ol>
    </div>
</div>



<form name="form_input" method="post" action="<%=request.getContextPath() %>${tag}">
<c:if test="${!empty m }"><input type="hidden" value="${Cont.getBoard_no() }" name="board_no" /></c:if>
<div class="page-cont">
    <div class="row">
        <div class="col-lg-6 mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4>?????? ??????</h4>
                    <div class="row form">
                        <div class="form-group col">
                            <label for="board_id" style="padding: 9px 0;"><span>*</span> ????????? ?????????<br />(??????, ??????)</label>
                            <input type="text" name="board_id" id="board_id" value="${conid}" maxlength="30" class="form-control<c:if test="${!empty m}">-plaintext</c:if> w-30" onkeydown="EngNumInput(this);"<c:if test="${!empty m}"> readonly="readonly"</c:if> required="required" />
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col mb-2">
                            <label for="board_name"><span>*</span> ????????? ??????</label>
                            <input type="text" name="board_name" id="board_name" value="${conname}" maxlength="30" class="form-control w-30" required="required" />
                        </div>
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col mb-2">
                            <label for="board_skin">????????? ??????</label>
                            <select id="board_skin" name="board_skin" class="custom-select w-30">
								<option value="basic"<c:if test="${conskin eq 'basic'}"> selected="selected"</c:if>>basic</option>
                                <c:forEach var="skin" items="${skin_dir}">
								<option value="${skin}"<c:if test="${skin eq conskin}"> selected="selected"</c:if>>${skin}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col">
                            <label for="board_list_num" style="padding: 9px 0;">????????? ?????? ??????<br />(????????? ??????)</label>
                            <input type="text" name="board_list_num" id="board_list_num" value="${conLnum}" maxlength="2" class="form-control text-center w-20" onkeydown="NumberInput(this);" required="required" /> ???
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col">
                            <label for="board_page_num" style="padding: 9px 0;">????????? ?????? ??????<br />(????????? ??????)</label>
                            <input type="text" name="board_page_num" id="board_page_num" maxlength="1" value="${conPnum}" class="form-control text-center w-20" onkeydown="NumberInput(this);" required="required" /> ???
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <div class="col-lg-6 mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4>?????? ??????</h4>
                    <div class="row form">
                        <div class="form-group col-sm">
                            <label>???????????? ??????</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_use_cate and con_use_cate eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_category" value="Y"<c:if test="${!empty con_use_cate and con_use_cate eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_use_cate or con_use_cate eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_category" value="N"<c:if test="${empty con_use_cate or con_use_cate eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm">
                            <label>?????? ??????</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_use_comm and con_use_comm eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_comment" value="Y"<c:if test="${!empty con_use_comm and con_use_comm eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_use_comm or con_use_comm eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_comment" value="N"<c:if test="${empty con_use_comm or con_use_comm eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col-sm mb-2">
                            <label>????????? ??????</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_use_sec and con_use_sec eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_secret" value="Y"<c:if test="${!empty con_use_sec and con_use_sec eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_use_sec or con_use_sec eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_secret" value="N"<c:if test="${empty con_use_sec or con_use_sec eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm mb-2">
                            <label>????????? ??????</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_use_only_sec and con_use_only_sec eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_only_secret" value="Y"<c:if test="${!empty con_use_only_sec and con_use_only_sec eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_use_only_sec or con_use_only_sec eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_only_secret" value="N"<c:if test="${empty con_use_only_sec or con_use_only_sec eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col-sm mb-2">
                            <label style="padding: 9px 0;">???????????????<br />?????? #1</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_link1 and con_link1 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_link1" value="Y"<c:if test="${!empty con_link1 and con_link1 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_link1 or con_link1 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_link1" value="N"<c:if test="${empty con_link1 or con_link1 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm mb-2">
                            <label style="padding: 9px 0;">???????????????<br />?????? #2</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_link2 and con_link2 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_link2" value="Y"<c:if test="${!empty con_link2 and con_link2 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_link2 or con_link2 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_link2" value="N"<c:if test="${empty con_link2 or con_link2 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="w-100 border-bottom"></div>
                        <div class="form-group col-sm">
                            <label>???????????? #1</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_file1 and con_file1 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_file1" value="Y"<c:if test="${!empty con_file1 and con_file1 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_file1 or con_file1 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_file1" value="N"<c:if test="${empty con_file1 or con_file1 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm">
                            <label>???????????? #2</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_file1 and con_file2 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_file2" value="Y"<c:if test="${!empty con_file2 and con_file2 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_file2 or con_file2 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_file2" value="N"<c:if test="${empty con_file2 or con_file2 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="w-100"></div>
                        <div class="form-group col-sm">
                            <label>???????????? #3</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_file1 and con_file3 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_file3" value="Y"<c:if test="${!empty con_file3 and con_file3 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_file3 or con_file3 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_file3" value="N"<c:if test="${empty con_file3 or con_file3 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                        <div class="form-group col-sm">
                            <label>???????????? #4</label>
                            <div class="btn-group mt-2" role="group" data-toggle="buttons">
                                <label class="btn btn-outline-secondary<c:if test="${!empty con_file1 and con_file4 eq 'Y'}"> active</c:if>">
                                    <input type="radio" name="board_use_file4" value="Y"<c:if test="${!empty con_file4 and con_file4 eq 'Y'}"> checked="checked"</c:if> /><i class="fa fa-circle-o"></i> ??????
                                </label>
                                <label class="btn btn-outline-secondary<c:if test="${empty con_file4 or con_file4 eq 'N'}"> active</c:if>">
                                    <input type="radio" name="board_use_file4" value="N"<c:if test="${empty con_file4 or con_file4 eq 'N'}"> checked="checked"</c:if> /><i class="fa fa-times"></i> ??????
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="page-cont">
    <div class="row">
        <div class="col-lg mb-4">
            <div class="card input-form">
                <div class="card-body p-4">
                    <h4>?????? ??????</h4>
                    <div class="row form">
                        <div class="form-group col-sm">
                            <label for="board_level_list">????????????</label>
                            <select id="board_level_list" name="board_level_list" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_list eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_list eq 'user'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_list eq 'admin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm">
                            <label for="board_level_view">?????????</label>
                            <select id="board_level_view" name="board_level_view" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_view eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_view eq 'user'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_view eq 'admin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm">
                            <label for="board_level_write">?????????</label>
                            <select id="board_level_write" name="board_level_write" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_write eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_write eq 'user'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_write eq 'admin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>

                        <div class="w-100"></div>

                        <div class="form-group col-sm">
                            <label for="board_level_notice">???????????? ??????</label>
                            <select id="board_level_notice" name="board_level_notice" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_not eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_not eq 'user'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_not eq 'admin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm">
                            <label for="board_level_comment">????????????</label>
                            <select id="board_level_comment" name="board_level_comment" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_comm eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_comm eq 'usesr'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_comm eq 'amdin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm"></div>

                        <div class="w-100"></div>

                        <div class="form-group col-sm">
                            <label for="board_level_modify" style="padding: 9px 0;">?????? ??? ??????<br />?????? ??????</label>
                            <select id="board_level_modify" name="board_level_modify" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_mod eq 'null'}"> selected="selected"</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_mod eq 'user'}"> selected="selected"</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_mod eq 'admin'}"> selected="selected"</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm">
                            <label for="board_level_delete" style="padding: 9px 0;">?????? ??? ??????<br />?????? ??????</label>
                            <select id="board_level_delete" name="board_level_delete" class="custom-select w-40">
								<option value="null"<c:if test="${con_lv_del eq 'null'}">selected</c:if>>????????????</option>
								<option value="user"<c:if test="${con_lv_del eq 'user'}">selected</c:if>>??????</option>
								<option value="admin"<c:if test="${con_lv_del eq 'admin'}">selected</c:if>>?????????</option>
                            </select>
                        </div>
                        <div class="form-group col-sm"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<div class="d-flex mt-2 input-form-button">
	<div class="col-lg text-center">
		<c:if test="${!empty m }"><a href="${path}/admin/board/board_delete.do?board_no=${Cont.getBoard_no()}" class="btn btn-danger btn-lg m-2" onclick="return confirm('?????? ?????????????????????????\n????????? ??? ????????????.');"><i class="fa fa-trash-o"></i> ????????????</a></c:if>
		<a href="${path}/admin/board/board_list.do?keyword=${param.keyword}&page=${param.page}" class="btn btn-secondary btn-lg m-2"><i class="fa fa-bars"></i> ????????????</a>
		<button type="submit" class="btn btn-primary btn-lg m-2"><c:choose><c:when test="${!empty m}"><i class="fa fa-save"></i> ????????????</c:when><c:otherwise><i class="fa fa-pencil"></i> ????????????</c:otherwise></c:choose></button>
	</div>
</div>
</form>



<%@ include file="../layout/layout_footer.jsp" %>