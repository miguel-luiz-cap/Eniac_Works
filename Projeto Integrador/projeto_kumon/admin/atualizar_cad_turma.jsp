<%@ page language="java" import="java.sql.*" %>

<html lang="pt-BR">
<head>
	<title>Kumon - Salvar dados</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vprof = "";
	int vhorario = 0, vsala = 0, cod_turma, vaula = 0, vestagio = 0, delete = 0;

	cod_turma = Integer.parseInt(request.getParameter("txt_turma"));

	if(request.getParameter("txt_delete") != null && !(request.getParameter("txt_delete").equals(""))) 
		delete = Integer.parseInt(request.getParameter("txt_delete"));

	if(request.getParameter("txt_prof") != null && !(request.getParameter("txt_prof").equals(""))) 
		vprof = request.getParameter("txt_prof");

	if(request.getParameter("txt_horario") != null && !(request.getParameter("txt_horario").equals("")))
		vhorario = Integer.parseInt(request.getParameter("txt_horario"));

	if(request.getParameter("txt_sala") != null && !(request.getParameter("txt_sala").equals("")))
		vsala = Integer.parseInt(request.getParameter("txt_sala"));

	if(request.getParameter("txt_aula") != null && !(request.getParameter("txt_aula").equals("")))
		vaula = Integer.parseInt(request.getParameter("txt_aula"));

	if(request.getParameter("txt_estagio") != null && !(request.getParameter("txt_estagio").equals(""))) 
		vestagio = Integer.parseInt(request.getParameter("txt_estagio"));


	/*String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://10.4.0.90:1433/bd235282017"; // RA
	String usuario = "bd235282017"; // RA
	String senha = "123456";*/

	String driver = "net.sourceforge.jtds.jdbc.Driver";
	String url = "jdbc:jtds:sqlserver://192.168.15.7:1433/ScrashDB"; // RA
	String usuario = "Perfect_Scrash"; // RA
	String senha = "123456";

	String sql;
	sql = "";
	Boolean update = false;

	Class.forName(driver);
	Connection conexao = DriverManager.getConnection(url,usuario,senha);
	Statement stm = conexao.createStatement();

	if(delete == 1)
	{
		Boolean have_alunos = false;
		String consulta = "select * from aluno_kumon where alu_turma_cod = " + cod_turma + ";";;
		ResultSet dados = stm.executeQuery(consulta);
		while( dados.next() ) {
			if(Integer.parseInt(dados.getString("alu_turma_cod")) == cod_turma)
				have_alunos = true;
		}

		if(!have_alunos) {
			sql += "DELETE FROM turma_kumon WHERE cod_turma = " + cod_turma + ";";
			update = true;
		}
		else {
			out.print("<p class='txt_bold'>Erro !!!</p>Nao pode excluir turmas que tenham alunos<br/><br/>"); 
			out.print("<p align='center'><a href='conf_turma.jsp' class='box_login'>Voltar</a></p>");
			return;
		}
	}
	else {

		if(vprof != null && !vprof.equals("")) {
			sql += "UPDATE turma_kumon SET professor = '" + vprof + "' WHERE cod_turma = " + cod_turma + "; ";
			update = true;
		}

		if(vhorario > 0 && vhorario < 4) {
			sql += "UPDATE turma_kumon SET horario = '" + vhorario + "' WHERE cod_turma = " + cod_turma + "; ";
			update = true;
		}

		if(vsala > 0) {
			sql += "UPDATE turma_kumon SET sala = '" + vsala + "' WHERE cod_turma = " + cod_turma + "; ";
			update = true;
		}

		if(vaula > 0) {
			sql += "UPDATE turma_kumon SET aula = '" + vaula + "' WHERE cod_turma = " + cod_turma + "; ";
			update = true;
		}

		if(vestagio > 0) {
			sql += "UPDATE turma_kumon SET estagio = '" + vestagio + "' WHERE cod_turma = " + cod_turma + "; ";
			update = true;
		}
	 	


	}
	if(update) {
		stm.executeUpdate(sql); 

		if(delete == 1)
			out.print("<p class='txt_bold'>Turma EXCLUIDA com sucesso!!!</p><br/>");
		else
			out.print("<p class='txt_bold'>Dados alterados com sucesso!!!</p><br/>");
	}
	else {
		out.print("<p class='txt_bold'>Erro !!!</p><br/>Todos os dados estao em branco (Nenhum dado foi alterado)<br/>"); 
	}

	out.print("<p align='center'><a href='conf_turma.jsp' class='box_login'>Voltar</a></p>");

%>

	</div>
</div>
</body>
</html>