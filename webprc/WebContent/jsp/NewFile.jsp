<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>무작정 레이아웃1</title>
    <style>
    *{  margin:0; padding:0; }
    body, html {  width:100%; height:100%; overflow-x: hidden;}
    a { text-decoration:none; color:#333; }
    ul { list-style:none; }
    #wrap { width:100%; height:100%; }
    #hd { width:100%; height:120px; background:#333;}
    .Logo { padding-top:8px; margin-left:5%; display:block; float:left; }
    #tnb { float:right; margin-right:5%; }
    #tnb li { float:left; padding:15px; }
    #tnb a { color:#fff; }
    #gnb { clear:both; width:100%; }
    #gnb li { float:left; width:25% }
    #gnb a { color:#fff; display:block; width:100%; line-height:60px; text-align:center; font-weight:bold; }
    #gnb a:hover { color: #0dbffa; }

    </style>
</head>
<body>
<!-- div#wrap>header#hd+section#contents+footer#ft  index페이지 기본태그 틀 생성 (범위지정 후 Ctrl+E) -->
    <div id="wrap">
        <header id="hd">
            <!-- (a.logo>img)+(nav#tnb>ul>(li>a)*3)+(nav#gnb>ul>(li>a)*4)   로고태그, 상단메뉴태그 -->
            <a href="index.html" class="Logo">
                <img src="http://placehold.it/120x38/ffffff/333333" alt="로고">
            </a>
            <nav id="tnb">
                <ul>
                    <li><a href="login.html">Login</a></li>
                    <li><a href="sitemap.html">Sitemap</a></li>
                    <li><a href="contact.html">Contact</a></li>
                </ul>
            </nav>
            <nav id="gnb">
                <ul>
                    <li><a href="sub1.html">Company</a></li>
                    <li><a href="sub2.html">Product</a></li>
                    <li><a href="sub3.html">Service</a></li>
                    <li><a href="sub4.html">Help</a></li>
                </ul>
            </nav>
        </header>
        <section id="contents">
        <!-- (aside#leftbar>nav#lnb>ul>(li>a)*4)+(article.art>h2.title+(figure#visual>img)+p.con)   좌측(우측) 메뉴태그 -->
            <aside id="leftbar">
                <nav id="lnb">
                    <ul>
                        <li><a href="#page1">회사연혁</a></li>
                        <li><a href="#page2">CEO 인사말</a></li>
                        <li><a href="#page3">조직 및 사업</a></li>
                        <li><a href="#page4">오시는 길</a></li>
                    </ul>
                </nav>
            </aside>
            <article class="art">
                <h2 class="title">제목</h2>
                <figure id="visual">
                    <img src="http://placehold.it/900x400" alt="배너">
                </figure>
                <p class="con">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            </article>
        </section>
        <footer id="ft">
            <!-- address+p.copyright   하단메뉴 태그-->
            <address>대전광역시 서구 둔산동 오라클빌딩 3층</address>
            <p class="copyright">Copyright 2017 kim. All rights reserved</p>
        </footer>
    </div>
</body>
</html>