﻿Imports IntranetBL

Public Class RepGastosNSCuentaAcumTodo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2013 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)
            items.Add(New ListItem("Enero", "1"))
            items.Add(New ListItem("Febrero", "2"))
            items.Add(New ListItem("Marzo", "3"))
            items.Add(New ListItem("Abril", "4"))
            items.Add(New ListItem("Mayo", "5"))
            items.Add(New ListItem("Junio", "6"))
            items.Add(New ListItem("Julio", "7"))
            items.Add(New ListItem("Agosto", "8"))
            items.Add(New ListItem("Septiembre", "9"))
            items.Add(New ListItem("Octubre", "10"))
            items.Add(New ListItem("Noviembre", "11"))
            items.Add(New ListItem("Diciembre", "12"))
            Me.ddlMes.Items.AddRange(items.ToArray)

            Dim fecha_hoy As Date = Now.AddMonths(-1)
            Me.ddlAnio.SelectedValue = fecha_hoy.Year
            Me.ddlMes.SelectedValue = fecha_hoy.Month

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            Dim url As String = ""
            url = "RepGastosNSCuentaAcumTodoImpresion.aspx?e=6&a=" & Me.ddlAnio.SelectedValue & "&mon=" & Me.ddlMoneda.SelectedValue & "&m=" & Me.ddlMes.SelectedValue

            Dim script As String = "window.open('" + url + "','')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



End Class
