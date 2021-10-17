<%-- 
    Document   : Categoria
    Created on : 04/06/2021, 16:39:46
    Author     : Gabriel
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mysql.jdbc.Driver"%>
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
        <link href="CSS/estilousuario.css" rel="stylesheet" type="text/css"/>
        <title>Categorias</title>
    </head>
    <%
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
    %>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Home</a>
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
        <div class="container">
            <button type="button" data-toggle="modal" data-target="#modal">Adicionar Categorias</button>
            <br><br>
            <div class="row">
                <form class="d-flex" method="post">
                    <input class="form-control me-3" type="search" name="txtpesquisar" placeholder="Pesquisar Categoria.." aria-label="Pesquisar">
                    <button class="button" name="btnpesquisar" type="submit">Pesquisar</button>
                </form>
            </div><br>
            <h5>Categorias Cadastradas:</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">#ID</th>
                        <th scope="col">Categorias</th>
                        <th scope="col">Editar</th>
                        <th scope="col">Excluir</th>
                        <th scope="col">Gerenciar Item</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            st = new Conexao().getConexao().createStatement();
                            if (request.getParameter("btnpesquisar") != null) {
                                String pesquisar = '%' + request.getParameter("txtpesquisar") + '%';
                                rs = st.executeQuery("SELECT * FROM tb_categoria WHERE desc_categoria LIKE '" + pesquisar + "'");
                            } else {
                                rs = st.executeQuery("SELECT * FROM tb_categoria ORDER BY desc_categoria ASC");
                            }

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td>
                             <a href="altera_cat.jsp?id=<%= rs.getString(1)%>" class="text-info me-3" ><i class="far fa-edit"></i></a>
                        </td>
                        <td>
                            <a href="Categoria.jsp?funcao=excluir&id=<%= rs.getString(1)%>" class="text-danger"><i class="far fa-trash-alt"></i></a>
                        </td>
                        <td>
                            <a href="Itens.jsp?funcao=categoria&id=<%= rs.getString(1)%>" class="text-info me-3" ><i class="fas fa-cog"></i></a>
                        </td>
                    </tr>
                    <%}
                        } catch (Exception erro) {
                            throw new RuntimeException("Erro mostrarCategoria" + erro);
                        }
                    %>

                    <%
                        if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {

                            String id = request.getParameter("id");
                            try {
                                st = new Conexao().getConexao().createStatement();
                                st.executeUpdate("DELETE FROM tb_categoria WHERE id_categoria= '" + id + "' ");
                                response.sendRedirect("Categoria.jsp");
                            } catch (Exception erro) {
                                throw new RuntimeException("Erro excluirCategoria" + erro);
                            }
                        }
                    %>

                </tbody>
            </table>
        </div>

        <div class="modal fade" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Adicionar Categoria</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="cadastro-form" class="form" action="" method="post">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="username"><strong>Nome da Categoria:</strong></label><br><br>
                                <input type="text" name="txtnome" placeholder="Digite aqui.." class="form-control" id="txtnome">    
                            </div><br>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                            <button type="submit" name="btnsalvar" class="btn btn-primary">Salvar</button>
                        </div>
                        <%
                            if (request.getParameter("btnsalvar") != null) {
                                String categoria = request.getParameter("txtnome");

                                try {
                                    st = new Conexao().getConexao().createStatement();
                                    rs = st.executeQuery("SELECT * FROM tb_categoria WHERE desc_categoria='" + categoria + "'");
                                    while (rs.next()) {
                                        rs.getRow();
                                        if (rs.getRow() > 0) {
                                            out.print("<script>alert('Categoria já cadastrada!');</script>");
                                            return;
                                        }
                                    }
                                    st.executeUpdate("INSERT INTO tb_categoria (desc_categoria) "
                                            + " VALUES ('" + categoria + "')");
                                    response.sendRedirect("Categoria.jsp");
                                } catch (Exception erro) {
                                    out.print("erro inserirCategoria" + erro);
                                }
                            }
                        %>

                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
                integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
                integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
        crossorigin="anonymous"></script>
    </body>
</html>
