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
	<title>*ADMIN* Kumon - Cadastro do Aluno</title>
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

<body bgcolor="#f5f5f5" onLoad="load_page();">

<div class="barrinha">
<p><img src="../resources/logo_white_kumon.png" align="left"><stong>*ADMIN*</stong></p>

</div>

<div align="center">
	<div class="quadrado_central" id="conteudo">
		<p class="txt_bold">Cadastro do aluno:</p>

		<form name="form1" action="salvar_cadastro.jsp" method="post">
		<p class="txt_center">
		<input type="text" name="txt_nome" size="50" placeholder="Nome Completo:">
		<br/>
		<input type="text" name="txt_cpf" size="50" placeholder="CPF: (Somente Numeros)" onkeypress="return onlynumber();">
		<br/>
		<input type="text" name="txt_rg" size="50" placeholder="RG: (Somente Numeros)" onkeypress="return onlynumber();">
		<br/>
		<input type="text" name="txt_telefone" size="50" placeholder="Telefone: (Somente Numeros)" onkeypress="return onlynumber();">
		<br/>
		<input type="text" name="txt_endereco" size="50" placeholder="Endereco:">
		<br/>
		<input type="text" name="txt_email" size="50" placeholder="E-mail:"> 
		<br/><br/>

		<strong>Sexo:</strong><br/>
		<input type="radio" name="txt_sexo" value="F">Feminino
		<input type="radio" name="txt_sexo" value="M">Masculino

		<br/><br/>
		<strong>Turma:</strong><br/>
		<select name="txt_turma">
			<%
			//String consulta = "select * from turma_kumon";
			String consulta = "select * from cursos_kumon inner join turma_kumon on cod_curso = tur_curso_cod";
			ResultSet dados = stm.executeQuery(consulta);
			String horario = "", turma = "", curso = "";
			String sala = "", vaula = "", vestagio = "";
			while( dados.next() ) {
				turma = dados.getString("cod_turma");
				curso = dados.getString("nome_curso");
				sala = dados.getString("sala");
				vaula = dados.getString("aula");
				vestagio = dados.getString("estagio");
				if(dados.getString("horario").equals("1"))
					horario = "Turma: " + turma + " - Curso: " + curso +  " - Manha - Sala: " + sala + " - Aula Atual: " + vaula + " - Estagio: " + vestagio;

				else if(dados.getString("horario").equals("2"))
					horario = "Turma: " + turma + " - Curso: " + curso +   " - Tarde - Sala: " + sala + " - Aula Atual: " + vaula + " - Estagio: " + vestagio;

				else if(dados.getString("horario").equals("3"))
					horario = "Turma: " + turma + " - Curso: " + curso +  " - Noite - Sala: " + sala + " - Aula Atual: " + vaula + " - Estagio: " + vestagio;

				out.print("<option value=" + turma + ">" + horario + "</option>");
			}
			%>
		</select>

		<br/><br/>
		<button type="submit" name="gravar" class="box_login">Cadastrar</button>
		<button type="reset" name="reseta" class="box_login">Limpar Dados</button></p>
		</form>
		<br/><a href='admin_menu.html' class='box_login'>Voltar</a>

	</div>
</div>
</body>
</html>
