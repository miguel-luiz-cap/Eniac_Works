<%@ page language="java" import="java.sql.*" %>

<html lang="pt-BR">
<head>
	<title>*ADMIN* Kumon - Cadastro da turma</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vcurso = "", vprof = "";
	int vhorario = 0, vsala = 0;

	if(request.getParameter("txt_curso") != null && !(request.getParameter("txt_curso").equals(""))) 
		vcurso = request.getParameter("txt_curso");

	if(request.getParameter("txt_prof") != null && !(request.getParameter("txt_prof").equals(""))) 
		vprof = request.getParameter("txt_prof");

	if(request.getParameter("txt_horario") != null && !(request.getParameter("txt_horario").equals(""))) 
		vhorario = Integer.parseInt(request.getParameter("txt_horario"));

	if(request.getParameter("txt_sala") != null && !(request.getParameter("txt_sala").equals(""))) 
		vsala = Integer.parseInt(request.getParameter("txt_sala"));

	if(vcurso.equals("") || vprof.equals("") || vhorario <= 0 || sala <= 0) {
		out.print("<p class='txt_bold'>Erro!!!<br/><br/>Alguns dados nao foram preenchidos !!</p>");
		out.print("<p align='center'><a href='cadastro_turma.jsp' class='box_login'>Voltar</a></p>");
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

	Class.forName(driver);
	Connection conexao = DriverManager.getConnection(url,usuario,senha);

	String sql;

	// Criar a tabela caso nao exista
	sql = "if object_id('turma_kumon') is null ";
	sql += "begin ";
	sql += "create table turma_kumon ( ";
	sql += "cod_turma int identity(1,1) constraint pk_turma primary key, ";
	sql += "tur_curso_cod int, ";
	sql += "horario int, ";
	sql += "sala int, ";
	sql += "aula int, ";
	sql += "estagio int, ";
	sql += "professor varchar(30), ";
	sql += "constraint fk_turma_curso foreign key (tur_curso_cod) references cursos_kumon ";
	sql += "); ";
	sql += "end ";

	// Inserir Conteudo
	sql += "INSERT INTO turma_kumon (tur_curso_cod, horario, sala, professor, aula, estagio) values ( " ;
	sql += vcurso + ", ";	// Curso
	sql += vhorario + ", ";	// Horario
	sql += vsala + ", ";		// Sala
	sql += "'" + vprof + "', ";	// Professor
	sql += "1, 1 );";	// Aula e estagio

 	Statement stm = conexao.createStatement();
	stm.executeUpdate(sql); 

	out.print("<p class='txt_bold'>Turma Cadastrada com sucesso!!!</p><br/>");
	out.print("<p align='center'><a href='cadastro_turma.jsp' class='box_login'>Voltar</a></p>");

%>

	</div>
</div>
</body>
</html>