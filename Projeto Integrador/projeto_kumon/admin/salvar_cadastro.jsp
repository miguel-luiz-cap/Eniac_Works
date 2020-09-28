<%@ page language="java" import="java.sql.*" %>
<html lang="pt-BR">
<head>
	<title>Kumom - Cadastro do aluno</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vnome = "", vendereco = "", vsexo = "", vcpf = "", vrg = "", vtel = "";
	Integer	vturma = 0;
	String vemail = "";

	if(request.getParameter("txt_turma") != null && !(request.getParameter("txt_turma").equals(""))) 
		vturma = Integer.parseInt(request.getParameter("txt_turma"));

	if(request.getParameter("txt_nome") != null && !(request.getParameter("txt_nome").equals(""))) 
		vnome = request.getParameter("txt_nome");

	if(request.getParameter("txt_cpf") != null && !(request.getParameter("txt_cpf").equals(""))) 
		vcpf = request.getParameter("txt_cpf");

	if(request.getParameter("txt_rg") != null && !(request.getParameter("txt_rg").equals(""))) 
		vrg = request.getParameter("txt_rg"); 

	if(request.getParameter("txt_telefone") != null && !(request.getParameter("txt_telefone").equals(""))) 
		vtel = request.getParameter("txt_telefone");

	if(request.getParameter("txt_email") != null && !(request.getParameter("txt_email").equals(""))) 
		vemail = request.getParameter("txt_email");

	if(request.getParameter("txt_sexo") != null && !(request.getParameter("txt_sexo").equals(""))) 
		vsexo = request.getParameter("txt_sexo");

	if(request.getParameter("txt_endereco") != null && !(request.getParameter("txt_endereco").equals(""))) 
		vendereco = request.getParameter("txt_endereco"); // Pega os dados do email

	if(vturma == 0 || vnome.equals("") || vcpf.equals("") || vrg.equals("") || vtel.equals("") || vemail.equals("") || vsexo.equals("") || vendereco.equals("")) {
		out.print("<p class='txt_bold'>Erro!!!<br/><br/>Alguns dados nao foram preenchidos !!</p>");
		out.print("<p align='center'><a href='cadastro_aluno.jsp' class='box_login'>Voltar</a></p>");
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
	sql = "if object_id('aluno_kumon') is null ";
	sql += "begin ";
	sql += "CREATE TABLE aluno_kumon ( ";
	sql += "codigo	int identity(1,1) constraint PK_aluno_kumon primary key, ";
	sql += "alu_turma_cod int, ";
	sql += "nome varchar(50), ";
	sql += "cpf varchar(30), ";
	sql += "rg varchar(30), ";
	sql += "telefone varchar(30), ";
	sql += "sexo char(1), ";
	sql += "email varchar(50), ";
	sql += "endereco varchar(100), ";
	sql += "senha varchar(32), ";
	sql += "constraint ck_sexo check (sexo in ('M','F')), ";
	sql += "constraint fk_aluno_turma foreign key (alu_turma_cod) references turma_kumon ";
	sql += "); ";
	sql += "end ";

	// Inserir Conteudo
	sql += "INSERT INTO aluno_kumon (nome, cpf, rg, telefone, sexo, email, endereco, senha, alu_turma_cod) ";
	sql += "values ( ";
	sql += "'" + vnome + "', ";			// Nome
	sql += "'" + vcpf + "', ";			// CPF
	sql += "'" + vrg + "', ";			// RG
	sql += "'" + vtel + "', ";			// Telefone
	sql += "'" + vsexo + "', ";			// Sexo
	sql += "'" + vemail + "', ";		// Email
	sql += "'" + vendereco + "', ";		// Endereco
	sql += "'" + vcpf + "', ";			// Senha (Senha inicial eh o CPF)
	sql += vturma + ");";						// turma


 	Statement stm = conexao.createStatement();
	stm.executeUpdate(sql); 

 	String consulta = "select codigo, senha from aluno_kumon where cpf = '" + vcpf + "'";
	ResultSet dados = stm.executeQuery(consulta);

	out.print("<p class='txt_bold'>Aluno(a) Cadastrado(a) com sucesso!!!<br/><br/>Dados:</p>");
	while( dados.next() ) {
		out.print("Login: " + dados.getString("codigo") + "<br>");	
		out.print("Senha: " + dados.getString("senha") + "<br><br>");	
	}	
	out.print("Nome: " + vnome + "<br>");
	out.print("Cpf: " + vcpf + "<br>");
	out.print("RG: " + vrg + "<br>");
	out.print("Telefone: " + vtel + "<br>");
	out.print("E-mail: " + vemail + "<br>");
	out.print("Sexo: " + vsexo + "<br>");
	out.print("Endereco: " + vendereco + "<br><br>");	
	out.print("<p align='center'><a href='cadastro_aluno.jsp' class='box_login'>Voltar</a></p>");

%>
</div>
</div>
</body>
</html>

