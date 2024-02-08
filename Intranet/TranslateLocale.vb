
Namespace LocalizationIntranet

    Public NotInheritable Class TranslateLocale

        Public Shared Function text(key As String) As String

            If (HttpContext.Current.Request.Cookies("cookieIdioma") IsNot Nothing) Then
                If HttpContext.Current.Request.Cookies("cookieIdioma").Value = "es" Then
                    Return key
                End If
            Else
                Return key
            End If


            Dim tablaTraducciones As Hashtable = HttpContext.Current.Application("tablaTraducciones")
            If tablaTraducciones.ContainsKey(key) Then
                Return tablaTraducciones(key)
            End If

            Return key
        End Function

        Public Shared Function text(key As String, locale As String) As String

            If locale = "es" Then
                Return key
            End If


            Dim tablaTraducciones As Hashtable = HttpContext.Current.Application("tablaTraducciones")
            If tablaTraducciones.ContainsKey(key) Then
                Return tablaTraducciones(key)
            End If

            Return key
        End Function

        Public Shared Function isEnglish() As Boolean

            If (HttpContext.Current.Request.Cookies("cookieIdioma") IsNot Nothing) Then
                If HttpContext.Current.Request.Cookies("cookieIdioma").Value = "es" Then
                    Return False
                Else
                    Return True
                End If
            Else
                Return False
            End If

        End Function

        Public Shared Function getLocale() As String

            If (HttpContext.Current.Request.Cookies("cookieIdioma") IsNot Nothing) Then
                Return HttpContext.Current.Request.Cookies("cookieIdioma").Value
            Else
                Return "es"
            End If

        End Function


    End Class


End Namespace


