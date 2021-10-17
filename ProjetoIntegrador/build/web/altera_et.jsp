<%-- 
    Document   : altera_item
    Created on : 07/06/2021, 02:19:30
    Author     : Gabriel
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DAO.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/dde1e4ecb3.js" crossorigin="anonymous"></script>
        <title>Alterar Categoria</title>
    </head>
    <%
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
    %>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="Usuarios.jsp">Home</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" >GERENCIAR</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="Usuarios.jsp">USUARIOS</a></li>
                                <li><a class="dropdown-item" href="Categoria.jsp">ITENS</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" >PESQUISAR</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="PesquisaCategoria.jsp">CATEGORIAS</a></li>
                                <li><a class="dropdown-item" href="PesquisaItem.jsp">ITENS</a></li>
                                <li><a class="dropdown-item" href="PesquisaEtiqueta.jsp">ETIQUETAS</a></li>
                            </ul>
                        </li>
                        <li class="nav-relatorio">
                            <a class="nav-link active" aria-current="page" href="Relatorios.jsp">RELATORIO</a>
                        </li>
                    </ul>
                    <form class="form-inline my-2">
                        <small>
                            <%
                                String nomeUsuario = (String) session.getAttribute("nomeUsuario");
                                out.print(nomeUsuario);

                                if (nomeUsuario == null) {
                                    response.sendRedirect("index.jsp");
                                }
                            %>
                        </small>
                        <a href="Logout.jsp"><i class="fas fa-sign-out-alt"></i></a>
                    </form>
                </div>
            </div>
        </nav>
        <br>
        <br>

        <form class="container">
            <div class="container">
                <h5 class="modal-title" id="exampleModalLabel">Alterar Etiqueta:</h5>
            </div>
            <div class="modal-body">
                <%
                    String id = "";
                    String idpro = "";
                    String et = "";
                    String estado = "";
                    String status = "";
                    String desc = "";

                    if (request.getParameter("id") != null) {
                        id = request.getParameter("id");
                        try {
                            st = new Conexao().getConexao().createStatement();
                            rs = st.executeQuery("SELECT * FROM tb_patrimonio WHERE id_patrimonio= '" + id + "' ");
                            while (rs.next()) {
                                id = rs.getString(1);
                                idpro = rs.getString(2);
                                et = rs.getString(3);
                                estado = rs.getString(4);
                                status = rs.getString(5);
                                desc = rs.getString(6);
                            }
                        } catch (Exception erro) {
                            out.print("erro buscarPatrimonio" + erro);
                        }
                    }
                %>
                <div class="form-group">
                    <label for="id">ID Patrimonio:</label><br>
                    <input value="<%=id%>" type="text" name="txtid" class="form-control" id="txtid" readonly>
                </div><br>
                <div class="form-group">
                    <label for="id">ID Produto:</label><br>
                    <input value="<%=idpro%>" type="text" name="txtidpro" class="form-control" id="txtid" readonly>
                </div><br>
                <div class="form-group">
                    <label for="name">Etiqueta:</label><br>
                    <input value="<%=et%>" type="text" name="txtet" class="form-control" id="txtnome" readonly>
                </div><br>
                <div class="form-group">
                    <label for="desc">Estado:</label><br>
                    <input value="<%=estado%>" type="text" name="txtestado" class="form-control" id="txtnome">
                </div><br>
                <div class="form-group">
                    <label for="exampleFormControlSelect2">Status:</label>
                    <select class="form-control" name="txtstatus" id="exampleFormControlSelect1">
                        <option value="<%=status%>"><%=status%></option>
                        <%
                            if (!status.equals("ATIVO")) {
                                out.print("<option>ATIVO</option>");
                            }
                            if (!status.equals("INATIVO")) {
                                out.print("<option>INATIVO</option>");
                            }
                        %>
                    </select>
                </div><br>
                <div class="form-group">
                    <label for="qntd">Descrição:</label><br>
                    <input value="<%=desc%>" type="text" name="txtdesc" class="form-control" id="txtnome">
                </div><br>
            </div>
            <br>
            <div class="button">
                <button type="submit" name="btnsalvar" class="btn btn-primary">Salvar Alterações</button>
            </div>
        </form>
        <%
            if (request.getParameter("btnsalvar") != null) {

                String etid = request.getParameter("txtid");
                String etpro = request.getParameter("txtidpro");
                String etiqueta = request.getParameter("txtet");
                String etestado = request.getParameter("txtestado");
                String etstatus = request.getParameter("txtstatus");
                String etdesc = request.getParameter("txtdesc");
                try {
                    st = new Conexao().getConexao().createStatement();
                    st.executeUpdate("UPDATE tb_patrimonio SET produto_id ='" + etpro + "', et_patrimonio='" + etiqueta + "', estado_patrimonio='" + etestado + "', status_patrimonio='" + etstatus + "', desc_patrimonio='" + etdesc + "' WHERE id_patrimonio='" + etid + "'");
                    response.sendRedirect("PesquisaEtiqueta.jsp");
                } catch (Exception erro) {
                    throw new RuntimeException("erro AlterarEtiqueta" + erro);
                }
            }
        %>    
    </body>
</html>