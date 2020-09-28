<%@ page language="java" import="java.sql.*" %>
<html lang="pt-BR">
<head>
	<title>Kumom - Login</title>
	<link rel="stylesheet" type="text/css" href="kumon_css.css">
</head>

<body bgcolor="#f5f5f5">

<div class="barrinha">
<p><img src="resources/logo_white_kumon.png" align="left"><stong>Portal do aluno</stong></p>

</div>

<div align="center">
	<div class="quadrado_central">
		<%

			String login_codigo, login_senha;

			login_codigo = request.getParameter("txt_id_matricula");
			login_senha = request.getParameter("pwd_senha");

			if (login_codigo == null || login_codigo.equals("") || login_senha == null || login_senha.equals("")) {
				response.sendRedirect("login.html");
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
			Statement stm = conexao.createStatement();

			String data_senha;
			boolean acess_ok = false;

			String consulta = "select * from aluno_kumon where codigo =" + login_codigo;

			ResultSet dados = stm.executeQuery(consulta);

			while( dados.next() ) {
				if(login_senha.equals(dados.getString("senha"))  && login_codigo.equals(dados.getString("codigo"))) {
					out.print("<p class='txt_bold'>Login:</p>");
					out.print("<form name='form1' action='home.jsp' method='post'>");
					out.print("Login efetuado com sucesso:<br/>");
					out.print("<input type='hidden' readonly='true' name='txt_id_matricula' value='" + dados.getString("codigo")  + "'>");
					out.print("<input type='hidden' readonly='true' name='txt_nome' value='" + dados.getString("nome")  + "'>");
					out.print("<input type='hidden' readonly='true' name='txt_turma' value='" + dados.getString("alu_turma_cod")  + "'>");
					out.print("<br/>" + "<button type='submit' name='gravar' value='Entrar' class='box_login'>OK</button>");
					out.print("</form>");
					acess_ok = true;
				}
			}

			if(!acess_ok)
			{
				out.print("<p class='txt_bold'>Erro:</p>Usuario ou Senha Incorretos !!!");
				out.print("<p align='center'><a href='login.html' class='box_login'>Voltar</a></p>");
				return;
			}
		%>
	</div>
</div>
</body>
</html>
