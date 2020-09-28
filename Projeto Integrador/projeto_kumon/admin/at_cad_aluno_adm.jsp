<%@ page language="java" import="java.sql.*" %>
<html lang="pt-BR">
<head>
	<title>Kumom - Configuracoes da conta</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>Portal do aluno</stong></p>
</div>

<div align="center">
	<div class="quadrado_central">
<%
	String vnome = "", vendereco = "", vsexo = "", vcpf = "", vrg = "", vtel = "", vsenha = "" ,vemail = "";
	int	vturma = 0, vcodigo = 0, delete = 0;

	if(request.getParameter("txt_delete") != null && !(request.getParameter("txt_delete").equals(""))) 
		delete = Integer.parseInt(request.getParameter("txt_delete"));

	if(request.getParameter("txt_codigo") != null && !(request.getParameter("txt_codigo").equals(""))) 
		vcodigo = Integer.parseInt(request.getParameter("txt_codigo"));

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

	if(request.getParameter("txt_endereco") != null && !(request.getParameter("txt_endereco").equals(""))) 
		vendereco = request.getParameter("txt_endereco");

	if(request.getParameter("txt_senha") != null && !(request.getParameter("txt_senha").equals(""))) 
		vsenha = request.getParameter("txt_senha");
	

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

	if(delete == 1)	{
		sql += "DELETE FROM aluno_kumon WHERE codigo =" + vcodigo + "; ";
		update = true;
	} 
	else {
		if(vturma != 0) {
			sql += "UPDATE aluno_kumon SET alu_turma_cod = " + vturma + " WHERE codigo = " + vcodigo + "; ";
			update = true;
		}

		if(!vnome.equals("")) {
			sql += "UPDATE aluno_kumon SET nome = '" + vnome + "' WHERE codigo = " + vcodigo + "; ";
			update = true;
		}

		if(!vrg.equals("")) {
			sql += "UPDATE aluno_kumon SET rg = '" + vrg + "' WHERE codigo = " + vcodigo + "; ";
			update = true;
		}

		if(!vcpf.equals("")) {
			sql += "UPDATE aluno_kumon SET cpf = '" + vcpf + "' WHERE codigo = " + vcodigo + "; ";
			update = true;
		}

		if(!vtel.equals("")) {
			sql += "UPDATE aluno_kumon SET telefone = '" + vtel + "' WHERE codigo = " + vcodigo + "; ";
			update = true;
		}

		if(!vsexo.equals("")) {
			sql += "UPDATE aluno_kumon SET sexo = '" + vsexo + "' WHERE codigo = " + vcodigo + "; ";
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
	}

	if(update) {
		Class.forName(driver);
		Connection conexao = DriverManager.getConnection(url,usuario,senha);
	 	Statement stm = conexao.createStatement();
		stm.executeUpdate(sql); 
		
		if(delete == 1)
			out.print("<p align='center' style='margin: 0px;'>Aluno(a) EXCLUIDO com Sucesso!!<br/>");
		else
			out.print("<p align='center' style='margin: 0px;'>Dados alterados com sucesso !!<br/>");
	}
	else {
		out.print("<p align='center' style='margin: 0px;'>Todos os dados estao em branco !!<br/>Nenhum dado foi salvo.<br/>");
	}

	out.print("<br/><a href='conf_cad_aluno_adm.jsp' class='box_login'>Voltar</a></p>");

%>
	</div>
</div>
</body>
</html>
