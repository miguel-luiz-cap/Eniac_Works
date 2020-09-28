<%@ page language="java" import="java.sql.*" %>

<html lang="pt-BR">
<head>
	<title>*ADMIN* Kumon - Cadastro do curso</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vcurso = "";

	if(request.getParameter("txt_curso") != null && !(request.getParameter("txt_curso").equals("")))
		vcurso = request.getParameter("txt_curso");

	if(vcurso.equals("")) {
		out.print("<p class='txt_bold'>Erro!!!<br/><br/>Todos os dados estao em branco !!</p>");
		out.print("<p align='center'><a href='cadastro_curso.html' class='box_login'>Voltar</a></p>");
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
	sql = "if object_id('cursos_kumon') is null ";
	sql += "begin ";
	sql += "CREATE TABLE cursos_kumon ( ";
	sql += "cod_curso int identity(1,1) constraint pk_cursos primary key, ";
	sql += "nome_curso varchar(50) ";
	sql += "); ";
	sql += "end ";

	// Inserir Conteudo
	sql += "INSERT INTO cursos_kumon (nome_curso) values ('" + vcurso + "'); ";

 	Statement stm = conexao.createStatement();
	stm.executeUpdate(sql); 

 	String consulta = "select nome_curso from cursos_kumon where nome_curso = '" + vcurso + "'";
	ResultSet dados = stm.executeQuery(consulta);
	boolean sucess = false;
	while( dados.next() ) {
		out.print("<p class='txt_bold'>Curso Cadastrado com sucesso!!!</p><br/>");
		out.print("Nome do curso cadastrado: " + dados.getString("nome_curso") + "<br/>");	
		out.print("<p align='center'><a href='cadastro_curso.html' class='box_login'>Voltar</a></p>");
		sucess = true;
	}
	if(!sucess) {
		out.print("<p class='txt_bold'>Erro ao cadastrar o curso !!!</p><br/>");
		out.print("<p align='center'><a href='cadastro_curso.html' class='box_login'>Voltar</a></p>");
	}
%>

	</div>
</div>
</body>
</html>