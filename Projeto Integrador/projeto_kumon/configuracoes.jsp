<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<title>Kumon - Cadastro do Aluno</title>
	<link rel="stylesheet" type="text/css" href="kumon_css.css">

	<script type="text/javascript">
		function onlynumber(evt) {
		   var theEvent = evt || window.event;
		   var key = theEvent.keyCode || theEvent.which;
		   key = String.fromCharCode( key );
		   //var regex = /^[0-9.,]+$/;
		   var regex = /^[0-9.]+$/;
		   if( !regex.test(key) ) {
		      theEvent.returnValue = false;
		      if(theEvent.preventDefault) theEvent.preventDefault();
		   }
		}

	</script>
</head>

<body bgcolor="#f5f5f5">
<div class="barrinha">
<p><img src="resources/logo_white_kumon.png" align="left"><stong>Configuracoes</stong></p>
</div>
<%

	String vnome;
	int  vturma, vcodigo;

	vcodigo = Integer.parseInt(request.getParameter("txt_id_matricula"));
	vnome = request.getParameter("txt_nome"); // Pega os dados do nome
	vturma = Integer.parseInt(request.getParameter("txt_turma"));

	out.print("<div class='barrinha2'><ul style='display: inline-flex; list-style-type: none;'><li style='padding-right: 20px;'>");
	out.print("<form name='form1' action='configuracoes.jsp' id='config' method='post'>");
	out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
	out.print("<a onClick=\"document.getElementById('config').submit();\" class='link'>Configuracoes</a>");
	out.print("</form></li>");
	out.print("<li style='padding-right: 20px;'><a href='login.html' class='link'>Sair</a></li></ul></div>");
%>
<div align="center">
	<div class="quadrado_central">
		<p class="txt_bold">Configuracoes da conta:</p>
		<form name="form1" action="atualizar_cadastro.jsp" method="post">

		<p style="font-weight: bold;">
			Telefone:<br/>
			<input type="text" name="txt_telefone" size="30" placeholder="Telefone: (Somente Numeros)" style="margin-top: 1%;" onkeypress="return onlynumber();">
			<br/>

			<br/>Endereco:<br/>
			<input type="text" name="txt_endereco" size="30" placeholder="Endereco:" style="margin-top: 1%;">
			<br/>

			<br/>E-mail:<br/>
			<input type="text" name="txt_email" size="30" placeholder="E-mail:" style="margin-top: 1%;"> 
			<br/>

			<br/>Senha:<br/>
			<input type="password" name="txt_senha" size="30" placeholder="Senha:" style="margin-top: 1%;"> 
			<br/>

			<br/>Confirmar Senha:<br/>
			<input type="password" name="txt_senha2" size="30" placeholder="Confirmar Senha:" style="margin-top: 1%;"> 
			<br/>

			</br>
		</p>

		<%
			out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
			out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
			out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
			
			out.print("<p align='center'><button type='submit' name='gravar' class='box_login'>Salvar dados</button></form></p>");

			// Botao Voltar
			out.print("<form name='form1' action='home.jsp' method='post'>");
			out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
			out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
			out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
			out.print("<p align='center' style='margin: 0px;'><button type='submit' class='box_login'>Voltar</button></p>");
			out.print("</form>");
		%>


	</div>
</div>
</body>
</html>
