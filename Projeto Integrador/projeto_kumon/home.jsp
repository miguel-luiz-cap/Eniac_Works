<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html" import="java.util.Date, java.text.*" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="pt-BR"><head>
	<title>Kumom - Aluno Home</title>
	<link rel="stylesheet" type="text/css" href="kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="resources/logo_white_kumon.png" align="left"><stong>Bem-vindo</stong></p>
</div>

<%
	String vnome;
	int  vturma, vcodigo;

	vcodigo = Integer.parseInt(request.getParameter("txt_id_matricula"));
	vnome = request.getParameter("txt_nome"); // Pega os dados do nome
	vturma = Integer.parseInt(request.getParameter("txt_turma"));

	// Barrinha de configuracoes
	out.print("<div class='barrinha2'><ul style='display: inline-flex; list-style-type: none;'><li style='padding-right: 20px;'>");
	out.print("<form name='form1' action='configuracoes.jsp' id='config' method='post'>");
	out.print("<input type='hidden' readonly='true' name='txt_id_matricula' size='50' value='" + vcodigo  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_nome' size='50' value='" + vnome  + "'>");
	out.print("<input type='hidden' readonly='true' name='txt_turma' size='50' value='" + vturma  + "'>");
	out.print("<a onClick=\"document.getElementById('config').submit();\" class='link'>Configuracoes</a>");
	out.print("</form></li>");
	out.print("<li style='padding-right: 20px;'><a href='login.html' class='link'>Sair</a></li></ul></div>");

	/*String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://10.4.0.90:1433/bd235282017"; // RA
	String usuario = "bd235282017"; // RA
	String senha = "123456";*/

	String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://192.168.15.7:1433/ScrashDB"; // RA
	String usuario = "Perfect_Scrash"; // RA
	String senha = "123456";

	Class.forName(driver);
	Connection conexao = DriverManager.getConnection(url,usuario,senha);
	Statement stm = conexao.createStatement();

	String consulta = "select * from cursos_kumon inner join turma_kumon on cod_curso = tur_curso_cod where cod_turma = " + vturma;
	ResultSet dados = stm.executeQuery(consulta);
	String horario = "";
	String materia = "";
	String vestagio = "";
	int vaula = 0;

	while( dados.next() ) {
		// Quadrado azul
		out.print("<div class='quadrado_esquerdo'>");
		out.print("<p class='txt_bold'>Aluno: " + vnome + "</p>");

		materia = dados.getString("nome_curso");
		out.print("<p>Curso: " + materia + "</p>");
		vaula = Integer.parseInt(dados.getString("aula"));
		vestagio = dados.getString("estagio");
		out.print("<p>Aula: " + vaula + "</p>");
		out.print("<p>Estagio: " + vestagio + "</p>");
		out.print("<p>Sala: " + dados.getString("sala") + "</p><br/>");

		if(dados.getString("horario").equals("1")) {
			horario = "Manha";
		}

		else if(dados.getString("horario").equals("2")){
			horario = "Tarde";
		}

		else if(dados.getString("horario").equals("3")) {
			horario = "Noite";
		}

		out.print("<p>Horario: " + horario + "</p>");
		out.print("<p>Professor: " + dados.getString("professor") + "</p>");

		// Lista de materiais
		String o_link;
		int i;

		out.print("</div><div class='quadrado_direito'><p class='txt_bold'>Lista de materiais</p><ul type='none'>");

		for (i = 1; i <= vaula; i++) {
			o_link = "material/" + materia + "/estagio_" + vestagio + "/aula_" + i + ".pdf";
			out.print("<li><a href='" + o_link + "' class='lista_materiais'>" + materia + " - Aula " + i + "</a></li><br/>");
		}
		out.print("</ul></p></div>");
	}
%>
</body></html>
