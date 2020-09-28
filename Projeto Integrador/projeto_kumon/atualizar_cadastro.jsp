<%@ page language="java" import="java.sql.*" %>
<html lang="pt-BR">
<head>
	<title>Kumom - Configuracoes da conta</title>
	<link rel="stylesheet" type="text/css" href="kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="resources/logo_white_kumon.png" align="left"><stong>Portal do aluno</stong></p>
</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vendereco = "", vemail = "", vsenha = "", vconfirmarsenha = "", vtel = "";

	if(request.getParameter("txt_telefone") != null && !(request.getParameter("txt_telefone").equals(""))) 
		vtel = request.getParameter("txt_telefone");

	if(request.getParameter("txt_email") != null && !(request.getParameter("txt_email").equals(""))) 
		vemail = request.getParameter("txt_email");

	if(request.getParameter("txt_endereco") != null && !(request.getParameter("txt_endereco").equals(""))) 
		vendereco = request.getParameter("txt_endereco");

	if(request.getParameter("txt_senha") != null && !(request.getParameter("txt_senha").equals(""))) 
		vsenha = request.getParameter("txt_senha");

	if(request.getParameter("txt_senha2") != null && !(request.getParameter("txt_senha2").equals(""))) 
		vconfirmarsenha = request.getParameter("txt_senha2");

	String vnome;
	int vturma, vcodigo;

	vcodigo = Integer.parseInt(request.getParameter("txt_id_matricula"));
	vnome = request.getParameter("txt_nome"); // Pega os dados do nome
	vturma = Integer.parseInt(request.getParameter("txt_turma"));

	if(!vsenha.equals(vconfirmarsenha) && !vsenha.equals(""))
	{
		out.print("<form name='form1' action='configuracoes.jsp' method='post'>");
		out.print("<p align='center' style='margin: 0px;'>Confirme a senha corretamente !!<br/>");
		out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
		out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
		out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
		out.print("<br/><button type='submit' class='box_login'>Voltar</button></p>");
		out.print("</form>");
	    return;
	}

	/*String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://10.4.0.90:1433/bd235282017"; // RA
	String usuario = "bd235282017"; // RA
	String senha = "123456";*/

	String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://192.168.15.7:1433/ScrashDB"; // RA
	String usuario = "Perfect_Scrash"; // RA
	String senha = "123456";

	String sql, redirectURL;
	boolean update;
	update = false;

	sql = "";

	if(!vtel.equals("")) {
		sql += "UPDATE aluno_kumon SET telefone = '" + vtel + "' WHERE codigo = " + vcodigo + "; ";
		update = true;
	}

	if(!vendereco.equals("")) {
		sql += "UPDATE aluno_kumon SET endereco = '" + vendereco + "' WHERE codigo = " + vcodigo + "; ";
		update = true;
	}

	if(!vemail.equals("")) {
		sql += "UPDATE aluno_kumon SET email = '" + vemail + "' WHERE codigo = " + vcodigo + "; ";
		update = true;
	}

	if(!vsenha.equals("")) {
		sql += "UPDATE aluno_kumon SET senha = '" + vsenha + "' WHERE codigo = " + vcodigo + "; ";
		update = true;
	}

	if(update) {
		Class.forName(driver);
		Connection conexao = DriverManager.getConnection(url,usuario,senha);
	 	Statement stm = conexao.createStatement();
		stm.executeUpdate(sql); 
		out.print("<form name='form1' action='home.jsp' method='post'>");
		out.print("<p align='center' style='margin: 0px;'>Dados alterados com sucesso !!<br/>");
	}
	else {
		out.print("<form name='form1' action='configuracoes.jsp' method='post'>");
		out.print("<p align='center' style='margin: 0px;'>Todos os dados estao em branco !!<br/>Nenhum dado foi salvo.<br/>");
	}
	out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
	out.print("<br/><button type='submit' class='box_login'>Voltar</button></p>");
	out.print("</form>");

%>
	</div>
</div>
</body>
</html>

