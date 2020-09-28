<%@ page language="java" import="java.sql.*" %>
<%
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
%>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<title>*ADMIN* Kumon - Cadastro da Turma</title>
	<link rel="stylesheet" type="text/css" href="../kumon_css.css">

	<script type="text/javascript">
		var senha, tentativas;
		tentativas = 0

		function load_page() {
			if(tentativas > 3) {
				alert('Numero Maximo de tentativas esgotadas');

				var node = document.getElementById("conteudo");
				if (node.parentNode) 
					node.parentNode.removeChild(node);

				document.write("ACESSO NEGADO !!!");

				return 0;
			}
			else if(tentativas <= 0)
				senha = prompt("Digite a senha");
			else
				senha = prompt("Senha Incorreta Tentativas " + tentativas + "/3");

			if(senha !== "aaa123") {
				tentativas++;
				return load_page();
			}

		}

	</script>

</head>

<body bgcolor="#f5f5f5" onLoad="load_page();">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central" id="conteudo">
		<p class="txt_bold">Cadastro da Turma:</p>
		<form name="form1" action="salvar_cad_turma.jsp" method="post">

		<p class="txt_center"><strong>Curso:</strong><br/>
		<select name="txt_curso">
		
		<%
		String consulta = "select * from cursos_kumon";
		ResultSet dados = stm.executeQuery(consulta);
		while( dados.next() ) {
			out.print("<option value=" + dados.getString("cod_curso") + ">" + dados.getString("nome_curso") + "</option>");
		}
		%>
		</select></p>

		<p class="txt_center"><strong>Horario:</strong><br/>
		<input type="radio" name="txt_horario" value="1">Manha
		<input type="radio" name="txt_horario" value="2">Tarde
		<input type="radio" name="txt_horario" value="3">Noite</p>

		<input type="text" name="txt_sala" size="50" placeholder="Sala de aula:">
		<br/>
		<input type="text" name="txt_prof" size="50" placeholder="Nome do professor(a):">
		<br/>

		<p align="center"><button type="submit" name="gravar" class="box_login">Cadastrar</button>
		<button type="reset" name="reseta" class="box_login">Limpar Dados</button></p>
		</form>
		<br/><a href='admin_menu.html' class='box_login'>Voltar</a>
	</div>
</div>
</body>
</html>
