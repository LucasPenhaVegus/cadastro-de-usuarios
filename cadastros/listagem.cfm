<cfoutput>
    <body>
        <main class="container-cadastro">
            <cfif session.tipoUsuario EQ "admin">
                <h2 class="title">Bem-vindo Administrdor!</h2>
            </cfif>
            <cfif session.tipoUsuario EQ "regular">
                <cfquery name="apresentacao" datasource="cadastro-vegus">
                    SELECT nome FROM Usuarios
                    WHERE nomeUsuario = <cfqueryparam value="#session.usuarioLogin#" cfsqltype="cf_sql_varchar">
                </cfquery>
                
                <h2>Bem-vindo #apresentacao.nome#!</h2>
            </cfif>

            <h2>Lista de Usu&aacute;rios</h2>

            <cfparam name="url.buscar" default="">
            <cfparam name="url.orderBy" default="">
            <cfparam name="url.orderDirection" default="ASC">

            <form action="listagem.cfm" method="get">
                <input type="text" name="buscar" id="buscar" placeholder="Digite para pesquisar">
                <button class="submit" type="submit">Buscar</button>
            </form>

            <section id="listagem" class="box">
                <div class="container-cadastro">
                    <table class="table" border="1">
                        <thead>
                            <tr class="cabecalho">
                                <th><a href="?orderBy=nomeUsuario&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">Nome de Usu&aacute;rio</a></th>
                                <th><a href="?orderBy=nome&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">Nome</a></th>
                                <th><a href="?orderBy=sobrenome&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">Sobrenome</a></th>
                                <th><a href="?orderBy=cpf&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">CPF</a></th>
                                <th><a href="?orderBy=dataNascimento&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">Data de Nascimento</a></th>
                                <th><a href="?orderBy=dataRegistro&orderDirection=<cfif structKeyExists(url, 'orderDirection') AND url.orderDirection EQ 'asc'>desc<cfelse>asc</cfif>">Registrado em</a></th>
                            </tr>
                        </thead>

                        <tbody>
                            <cfquery name="usuarios" dataSource="cadastro-vegus">
                                SELECT * FROM Usuarios
                                <cfif len(trim(url.buscar))>
                                    WHERE nome LIKE '%' + <cfqueryparam value="#url.buscar#" cfsqltype="cf_sql_varchar"> + '%'
                                    OR Sobrenome LIKE '%' + <cfqueryparam value="#url.buscar#" cfsqltype="cf_sql_varchar"> + '%'
                                    OR cpf LIKE '%' + <cfqueryparam value="#url.buscar#" cfsqltype="cf_sql_varchar"> + '%'
                                    OR nomeUsuario LIKE '%' + <cfqueryparam value="#url.buscar#" cfsqltype="cf_sql_varchar"> + '%'
                                    OR dataNascimento LIKE '%' + <cfqueryparam value="#url.buscar#" cfsqltype="cf_sql_varchar"> + '%'
                                </cfif>

                                <cfset colunasValidas = ["nomeUsuario","nome","sobrenome","cpf","dataNascimento","dataRegistro"]>

                                <cfif arrayContains(colunasValidas, url.orderBy)>
                                    <cfif len(trim(url.orderBy))>
                                        ORDER BY #url.orderBy#
                                        <cfif url.orderDirection EQ "desc">DESC<cfelse>ASC</cfif>
                                    </cfif>
                                <cfelse>
                                    ORDER BY nomeUsuario
                                    <cfif url.orderDirection EQ "desc">DESC<cfelse>ASC</cfif>
                                </cfif>
                            </cfquery>

                            <cfloop query="usuarios">
                                <tr>
                                    <td>#nomeUsuario#</td>
                                    <td>#nome#</td>
                                    <td>#sobrenome#</td>
                                    <td>#cpf#</td>
                                    <td>#dateFormat(dataNascimento, "dd/MM/yyyy")#</td>
                                    <td>#dateFormat(dataRegistro, "dd/MM/yyyy")#</td>
                                        <cfif structKeyExists(session, "tipoUsuario") AND session.tipoUsuario EQ "admin">
                                            <!---<a href="editar.cfm?id=#id#">Editar</a>
                                            <a href="excluir.cfm?id=#id#">Excluir</a>--->
                                        </cfif>
                                    </td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </body>
</cfoutput>