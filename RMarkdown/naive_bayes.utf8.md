
<!-- rnb-text-begin -->

---
title: "Naive Bayes"
output: html_notebook
---

Vamos a hacer un pequeño modelo estilo naive bayes, más que todo para practicar.

## Bibliotecas a usar


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShNQVNTKVxuXG5gYGAifQ== -->

```r
library(MASS)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Cargar los datos


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgPSByZWFkLmNzdihcIi4uL2RhdGEvZGF0b3NfZWRhLmNzdlwiLCBzZXAgPSAnOycpXG5oZWFkKGRmKVxuYGBgIn0= -->

```r
df = read.csv("../data/datos_eda.csv", sep = ';')
head(df)
```

<!-- rnb-source-end -->

<!-- rnb-frame-begin eyJtZXRhZGF0YSI6eyJjbGFzc2VzIjpbImRhdGEuZnJhbWUiXSwibnJvdyI6NiwibmNvbCI6MjR9LCJyZGYiOiJINHNJQUFBQUFBQUFCdDFXWFdnY1ZSUysyZXlQdTIxK3hGcERwWFllcEszaUpqWnBDb0k0bXpZL1JreE11MXBTYmRuZXpOelp2WFptN3ZiT1RHSWtTR2hBUXhUU0Z4K1VCb3RVMElLRnZraHRxMTFVS2dYQm45ckVHSldtK3VSRGhVWkJIMHc5czVrNzJkMXNVMW53eFlIRFBmZWMrNTJmZTg2Y21UM3QvUzJ4L2hoQ3FCb0ZnYXBEd0tMd3JyNXR6YTNOQ0FVRHNLc0NUZFJkWDRCVGR3SFRBRlRqSGtQbzRENkVrbGNSR3RpRjBMNDRRcmdlOXUrQnJ0YlZKOXFtNXUvNGRPRnFvbTI4ODNQMUZFbzhjZTNCZS9lUHpDYms1czRwYStmMXhNNkhKbWYvM3ZGbm9rMTlhU1E4ZjB6Z2N0cHpyZS8yRHorVzB6YVBUblh2SHN0cCt3OG80K1QxWE9iRVFzL3o2Ky9MSGJDKzJYVGpsOGxjK3ZyYkxjZHFMd2ljUExQNDh0aWpCNnZsNzNaUHYwYWJtRHdUdU5ZOCtWYUgvTzMwSCszbk52d3VmNTA2T1hIa0hTelBQbm44a3lNWGYvTnhaODU4ZWVIaTB6WHlSNmMrT3hGTjNTK2ZSNy9PVDF4YWtNOGFyMjY4Y3ZsSCtleFRyMnorcW5kQS92akd6Rjk5SCs3MWNjY1B5NUdSTDZybE44Wm1qanJ4ay9MN2x6YXUrL244WmZuMHVTM2pjeUZISHByKzROazNSN3ZsbzJQUFRBeldiMTIrTjlRRjlEQlFOeEJjTkhvRXFBV29QcTlmdXZDZ3pSM2k4U0VONjFabG0yS2p2akI2RTU0S0RYcFpST1pHM1haQmtTdEFQd0g5QVBSOWljTjdIcWZwakpSVU1venBVanZONnN6QVRWMGQ3WjU2YlpJWlJGS1lycE0wV1VWMkd6TjNiNDhQRTh3RlNGSkptaE9CcmUzQmxrMjRKYlV2U1lzRGpPd2hOdVZFOWJick9nd3dQbXdRMDVZMHhxVWhuQ1pXK2FNMVNhSnJjWkkvdjdxd3ZOSGlPTUtkeE1DNmlEblljM3UrSEtMWVptTWY1b2VvYVRFVDdzd2kyQ0pOUFd5UTVPTUFBZU1xNFZJeVN4U0tkV3JaZmxzVXQ4ZU9MbUlTam5XcGx6aWM2U3dOUjZXdEpqUGpLOHhMbG0vc2dRcGpxRFR5d3J3MzlXRE9LVkVsdUdzVm1zbXlxU0psTWJjaER5dERzLytIWTJWZVEyOFZyMkc1MTlUVnpRSE5DcjJyVzlLanFwSzE4RVkzOUJKcVorRE9vUlREa3VrR1JUV05LbzR1S2hiZFMvaHdYbDA1WkRWQjJUbFdablBMc1ZsRzhSL014bHNHK2EvaVdzbXZMRlBRVyt2S2xLbENKMFVPaTc3NklSTWIvcWhxOElRQktnWmJRTjNtYzgwKzErSnoyMzJ1VlRnaEtoYm9OY1JLS1E0RkFlT2VxRm9kRU5PMkhwdVVwVlNLMHlaenU1OHRXM0FVTVFMZFFVdUVKcHgyQjVYWXJiRnBscVVNb2k1RGErRTFBbWNwQTNOcVk5MlQzcGwzcERDREV2UEZQTUpUckM5V1dOUzA0YlBqeDVmRmh4MWlRdzVaeHQwNGhUa05LMVIzczBvcFJIZDBMSElMYW80aElva29sRHRwSDdOMmtLb0V2bDNZd0txUXhWenZWcW9BVkZkd0dha3NKRnBjcXloblE0MmlYbTdYQkx3T0NaY1dWZEd4SllvcWhERVYyN2hSNDRDSDNXSUpKTUt5Tm1VbWdBTHVQMkNvQkZ6RlN3UjFqdWxHb3NhVmpHTWVpcnYvT0xHOGVvbHF2RFZjd0Rjc3VRemM5RXlGL0JxYmFXcjZYYTNqQVNJcVZ3c1o1eE51ekhJb2pzZ0VwRmFqelpZckhJUC9BaUhKNTRZVy93RkIyejdvK3dvQUFBPT0ifQ== -->

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["id"],"name":[1],"type":["int"],"align":["right"]},{"label":["d1"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["d2"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["d3"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["d4"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["d5"],"name":[6],"type":["dbl"],"align":["right"]},{"label":["edad"],"name":[7],"type":["int"],"align":["right"]},{"label":["es_cuidador"],"name":[8],"type":["chr"],"align":["left"]},{"label":["dbs"],"name":[9],"type":["chr"],"align":["left"]},{"label":["anio_diagnostico"],"name":[10],"type":["int"],"align":["right"]},{"label":["educ"],"name":[11],"type":["chr"],"align":["left"]},{"label":["empleo"],"name":[12],"type":["chr"],"align":["left"]},{"label":["genero"],"name":[13],"type":["chr"],"align":["left"]},{"label":["tipo_medico"],"name":[14],"type":["chr"],"align":["left"]},{"label":["estado_marital"],"name":[15],"type":["chr"],"align":["left"]},{"label":["anio_comienzo_med"],"name":[16],"type":["int"],"align":["right"]},{"label":["anio_comienzo_sintomas"],"name":[17],"type":["int"],"align":["right"]},{"label":["paquetes_por_dia"],"name":[18],"type":["int"],"align":["right"]},{"label":["facilidad_celular"],"name":[19],"type":["chr"],"align":["left"]},{"label":["fumo"],"name":[20],"type":["chr"],"align":["left"]},{"label":["cirugia"],"name":[21],"type":["chr"],"align":["left"]},{"label":["videollamada"],"name":[22],"type":["chr"],"align":["left"]},{"label":["anios_fumo"],"name":[23],"type":["int"],"align":["right"]},{"label":["diagnostico_pro"],"name":[24],"type":["chr"],"align":["left"]}],"data":[{"1":"24665","2":"35.23343","3":"-178.8503","4":"0.374910","5":"0.096570","6":"0.032114","7":"71","8":"true","9":"false","10":"2011","11":"High School Diploma/GED","12":"Retired","13":"Female","14":"Parkinson Disease/Movement Disorder Specialist","15":"Married or domestic partnership","16":"2011","17":"2011","18":"NA","19":"Neither easy nor difficult","20":"false","21":"false","22":"false","23":"NA","24":"true","_rn_":"1"},{"1":"21472","2":"35.06466","3":"-177.2032","4":"0.379995","5":"0.115948","6":"0.024917","7":"48","8":"false","9":"NA","10":"NA","11":"Some college","12":"Employment for wages","13":"Male","14":"NA","15":"Married or domestic partnership","16":"NA","17":"NA","18":"NA","19":"Very easy","20":"false","21":"NA","22":"true","23":"NA","24":"false","_rn_":"2"},{"1":"25155","2":"53.76691","3":"-178.8864","4":"0.359551","5":"0.109389","6":"0.058175","7":"73","8":"false","9":"false","10":"2005","11":"Some college","12":"Retired","13":"Male","14":"NA","15":"Married or domestic partnership","16":"2005","17":"2005","18":"1","19":"Neither easy nor difficult","20":"true","21":"false","22":"false","23":"4","24":"true","_rn_":"3"},{"1":"22829","2":"31.19639","3":"-197.1547","4":"0.325620","5":"0.103234","6":"0.069262","7":"50","8":"false","9":"false","10":"2014","11":"High School Diploma/GED","12":"Self-employed","13":"Male","14":"General Neurologist (non-Parkinson Disease specialist)","15":"Married or domestic partnership","16":"NA","17":"2012","18":"NA","19":"Very easy","20":"false","21":"false","22":"true","23":"NA","24":"true","_rn_":"4"},{"1":"24848","2":"36.34814","3":"-117.8097","4":"0.271464","5":"0.102776","6":"0.005820","7":"57","8":"false","9":"false","10":"2012","11":"4-year college degree","12":"Self-employed","13":"Female","14":"Parkinson Disease/Movement Disorder Specialist","15":"Married or domestic partnership","16":"2012","17":"2011","18":"1","19":"Very easy","20":"true","21":"false","22":"true","23":"15","24":"true","_rn_":"5"},{"1":"21417","2":"34.78511","3":"-191.4573","4":"0.395302","5":"0.120893","6":"0.016126","7":"51","8":"false","9":"false","10":"2010","11":"Masters Degree","12":"Employment for wages","13":"Male","14":"Parkinson Disease/Movement Disorder Specialist","15":"Married or domestic partnership","16":"2010","17":"2009","18":"NA","19":"Very easy","20":"false","21":"false","22":"true","23":"NA","24":"true","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10],"total":[24]},"rows":{"min":[10],"max":[10],"total":[6]},"pages":{}}}
  </script>
</div>

<!-- rnb-frame-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubmFtZXMoZGYpXG5gYGAifQ== -->

```r
names(df)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIFsxXSBcImlkXCIgICAgICAgICAgICAgICAgICAgICBcImQxXCIgICAgICAgICAgICAgICAgICAgICBcImQyXCIgICAgICAgICAgICAgICAgICAgIFxuIFs0XSBcImQzXCIgICAgICAgICAgICAgICAgICAgICBcImQ0XCIgICAgICAgICAgICAgICAgICAgICBcImQ1XCIgICAgICAgICAgICAgICAgICAgIFxuIFs3XSBcImVkYWRcIiAgICAgICAgICAgICAgICAgICBcImVzX2N1aWRhZG9yXCIgICAgICAgICAgICBcImRic1wiICAgICAgICAgICAgICAgICAgIFxuWzEwXSBcImFuaW9fZGlhZ25vc3RpY29cIiAgICAgICBcImVkdWNcIiAgICAgICAgICAgICAgICAgICBcImVtcGxlb1wiICAgICAgICAgICAgICAgIFxuWzEzXSBcImdlbmVyb1wiICAgICAgICAgICAgICAgICBcInRpcG9fbWVkaWNvXCIgICAgICAgICAgICBcImVzdGFkb19tYXJpdGFsXCIgICAgICAgIFxuWzE2XSBcImFuaW9fY29taWVuem9fbWVkXCIgICAgICBcImFuaW9fY29taWVuem9fc2ludG9tYXNcIiBcInBhcXVldGVzX3Bvcl9kaWFcIiAgICAgIFxuWzE5XSBcImZhY2lsaWRhZF9jZWx1bGFyXCIgICAgICBcImZ1bW9cIiAgICAgICAgICAgICAgICAgICBcImNpcnVnaWFcIiAgICAgICAgICAgICAgIFxuWzIyXSBcInZpZGVvbGxhbWFkYVwiICAgICAgICAgICBcImFuaW9zX2Z1bW9cIiAgICAgICAgICAgICBcImRpYWdub3N0aWNvX3Byb1wiICAgICAgIFxuIn0= -->

```
 [1] "id"                     "d1"                     "d2"                    
 [4] "d3"                     "d4"                     "d5"                    
 [7] "edad"                   "es_cuidador"            "dbs"                   
[10] "anio_diagnostico"       "educ"                   "empleo"                
[13] "genero"                 "tipo_medico"            "estado_marital"        
[16] "anio_comienzo_med"      "anio_comienzo_sintomas" "paquetes_por_dia"      
[19] "facilidad_celular"      "fumo"                   "cirugia"               
[22] "videollamada"           "anios_fumo"             "diagnostico_pro"       
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

Observamos que id es una variable que no queremos usar.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgPC0gZGYgJT4lIHNlbGVjdCgtaWQpICU+JSBtdXRhdGUoZGlhZ25vc3RpY29fcHJvID0gZmFjdG9yKGRpYWdub3N0aWNvX3BybykpXG5gYGAifQ== -->

```r
df <- df %>% select(-id) %>% mutate(diagnostico_pro = factor(diagnostico_pro))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



## Modelo

El modelo que vamos a buscar plantear uno que este diagnostico_pro como variable respuesta en función de las otras. Como tenemos la restricción de independencia de las variables predictoras vamos a realizar un heatmap entre las variables numéricas.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudmFyX251bWVyaWNhcyA8LSBjKFwiZDFcIiwgIFwiZDJcIiwgXCJkM1wiLCBcImQ0XCIsIFwiZDVcIiwgXCJlZGFkXCIsIFwicGFxdWV0ZXNfcG9yX2RpYVwiLCBcImFuaW9zX2Z1bW9cIiApXG5cbmRmICU+JSBcbiAgc2VsZWN0KGFsbF9vZih2YXJfbnVtZXJpY2FzKSkgJT4lIFxuICBjb3IobWV0aG9kID0gXCJwZWFyc29uXCIpICU+JSBcbiAgZ2djb3JycGxvdChsYWIgPSBUUlVFKVxuYGBgIn0= -->

```r
var_numericas <- c("d1",  "d2", "d3", "d4", "d5", "edad", "paquetes_por_dia", "anios_fumo" )

df %>% 
  select(all_of(var_numericas)) %>% 
  cor(method = "pearson") %>% 
  ggcorrplot(lab = TRUE)
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


vemos que hay problemas con las variables paquetes_por_dia y anios_fumo. Sera por la cantidad de NAs?


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgJT4lIFxuICBzZWxlY3QoYWxsX29mKHZhcl9udW1lcmljYXMpKSAlPiUgXG4gIG1hcF9pbnQofiBzdW0oaXMubmEoLikpKVxuYGBgIn0= -->

```r
df %>% 
  select(all_of(var_numericas)) %>% 
  map_int(~ sum(is.na(.)))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgICAgICAgICBkMSAgICAgICAgICAgICAgIGQyICAgICAgICAgICAgICAgZDMgICAgICAgICAgICAgICBkNCBcbiAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgIDAgXG4gICAgICAgICAgICAgIGQ1ICAgICAgICAgICAgIGVkYWQgcGFxdWV0ZXNfcG9yX2RpYSAgICAgICBhbmlvc19mdW1vIFxuICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAwICAgICAgICAgICAgIDE1NjkgICAgICAgICAgICAgMTQ3MSBcbiJ9 -->

```
              d1               d2               d3               d4 
               0                0                0                0 
              d5             edad paquetes_por_dia       anios_fumo 
               0                0             1569             1471 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Con esto llegamos a la conclusión que es problema son los NAs, entonces los exlcuimos.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudmFyX251bWVyaWNhcyA8LSB2YXJfbnVtZXJpY2FzWy1jKDcsIDgpXVxuXG5kZiAlPiUgXG4gIHNlbGVjdChhbGxfb2YodmFyX251bWVyaWNhcykpICU+JSBcbiAgY29yKG1ldGhvZCA9IFwicGVhcnNvblwiKSAlPiUgXG4gIGdnY29ycnBsb3QobGFiID0gVFJVRSlcbmBgYCJ9 -->

```r
var_numericas <- var_numericas[-c(7, 8)]

df %>% 
  select(all_of(var_numericas)) %>% 
  cor(method = "pearson") %>% 
  ggcorrplot(lab = TRUE)
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


No observamos que exista variables altamente correlacionada. 

Además, deberemos verificar que su distrbución sea, o almenos aproximadamente, normal.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgJT4lIFxuICBzZWxlY3QoYWxsX29mKHZhcl9udW1lcmljYXMpKSAlPiUgXG4gIG1hcCh+IGdncGxvdChkZiwgYWVzKC4pKSArIGdlb21fZGVuc2l0eSgpKVxuYGBgIn0= -->

```r
df %>% 
  select(all_of(var_numericas)) %>% 
  map(~ ggplot(df, aes(.)) + geom_density())
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiJGQxXG5cbiRkMlxuXG4kZDNcblxuJGQ0XG5cbiRkNVxuXG4kZWRhZFxuIn0= -->

```
$d1

$d2

$d3

$d4

$d5

$edad
```



<!-- rnb-output-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAhoAAAFMCAMAAAC6WOVjAAAAk1BMVEUAAAAAADoAAGYAOpAAZrYzMzM6AAA6kNtNTU1NTW5NTY5NbqtNjshmAABmtv9uTW5uTY5ubqtuq+SOTU2OTW6OTY6OyP+QOgCQ2/+rbk2rbm6rbo6ryKur5P+2ZgC2///Ijk3I///bkDrb/7bb///kq27k///r6+v/tmb/yI7/25D/5Kv//7b//8j//9v//+T/////a5JuAAAACXBIWXMAAA7DAAAOwwHHb6hkAAANvElEQVR4nO2d62LbNhKF2dbZyEnTpE2bNBentrt24nUc8/2fbnWzJEoYEiBmiAu/80t1hNOjwachCfHStAg51aQOgHIVaCBBoIEEgQYSBBpIEGggQYFofB3S8DvMHYgQZwAaRJBGggYRhJGgQQRhJGgQQRgJGkQQRoIGEYSRoEEEYSRoEEEYCRpEEEaCBhGEkaBBBGEkaBBBGAkaox2ajpJEsDQAjdEOXRqccBRdBdAY6eAg4fRPRVcBNEY5uLcfX4//WnQVQGOMgxuM038ougqgMcZBRqP7L0VXATRGOIhkHP9b0VUAjXCHPjK6/1p0FUAj2KGfDNCwS6TmYBRhgIzOG4quAmgEOgyScfiWoqswEo35yqdQdRWTruHn4NE0Dt5UdBVAI8wBNEDD7eBFxv5tRVcBNIIcQAM03A6eZOzeWHQVQCPEATRAw+3gTcbTW4uuAmj4OwSQARoWidQckqKxeXPRVQANb4cgMkDDIJGaQ1o01m8vugqg4esQSAZo6CdSc0iMxmpA0VUADV8H0AANwSEYjeWIoqsAGp4O4WSAhnYiNQfQiDMADT+HEWSAhnYiNYfkaHxtiq4CaHg5jCIDNJQTqTkoRhhHxvhxjgjTG4CGjwNogIbbYfQMt9FsgIaFA2jEGYDGsMP4+QUN1URqDjmgEb23ARoWDqARZwAaww4xaMSyARoWDloRIiYXNFQTqTnkgUYkG6Bh4aAUIWZq60fj/s1V294sFosXV6ARalA1GndrJC7fzbJrRM1s7Whcnn9edo3HjxegMblB5mhsNigPb5cblHXjeLZU37urksK9l0q/fdMgGvevLw46hyGsag4qERS+89F9Jz7CuJG+aKy1298wTKTmoBFBZVUidkdWIcKokaDR46CzzF07Gncvb9vHTzM7eAUNr65xs1ic7w5SDBOpOcRH0PpJPXI9VSPCmJE+aJzKMJGaA2jEGYBGj9ROxIn67VYnwoiRoCEq/loB0FBNpOYAGnEGoCFK4brEncH4E4/VIoSPBA1BGrfHAA3VRGoOOaExmg3QsHCIM1C5FRdoqCZSc4gy0Lm3I2ioJlJzAI04A9BwSuk+0qChmkjNISs0xrIBGhYOoBFnABouaT3O5NBgHBugYeEw3kDt+VigoZpIzSEzNMaxARoWDqMN9J7FCRqqidQcxhooPvcbNFQTqTnkhsYoNkDDwmGkwcEEggZoHOhw/rQjjGADNCwcQCPOADSOZInGCDZAw8IBNOIMQKOrzuSBBmjsBRr7kaBxqO7c6UcIZgM0LBxAI85gJBqVyr4KBdaZrrHS0ZfaIEJo2yivaxgmUnMINzieN4sIgWyAhoUDaMQZgMZeJ7NmEiGMDdCwcMgUjTA2QMPCATTiDEBjp9MpM4oQwgZoWDiARpwBaOwEGkcjQeNJoHE0EjSeNBkaIWyAhoVDoIFjvkADNFaaEI0ANkDDwiHMwDVbdhG82QANCwfQiDMAja2mRcObDdCwcAgycE4VaIDG9Gj4sgEaFg4hBu6JAg3QSICGJxugYeGQORp+bICGhUOAgTBLoAEaoOEaCRpfQcM90oHG91c//T0rNKRJMo7gw0ZmaLTtl6b55b+gARqnaKw6R9M8Bw3bCB5sZIjGBo6f/wENwwhlonHdNGfLDYu0WTFMpOaQPxoebOSGxo/3TfPb6sU3qW0YJlJz8DYQJwg0jtH4/krckICGboRBNrJD46hl3L+5atuHt4uXt6ChG6F0NO4WL67axw/v2ptfa0RDnp4JIgyxkRUayx3Qrc42f7g8/7zsGg9/XW26B2hoRigKjV3X2GuFxP3vt+3DnxfL/3q2lLgTUqDS3kMp/zs49SZcoXH38gmNlQxhVXPwNOj53k4RYaBt5NQ1li1jtdi1Umc3dN81QEMzQkFoSF2j1n2NvqkBDS80Hj/8UeURCmiII11obDYq+3Wvmtc1UqMxwEZuaHw5a69//uf6TO4jhonUHLwMeicGNI7RWDaNH+/P5B9QQKO2CO6RbjS+v3oOGvOJ4B7pQOPH++fffvp7tVmpHo0cunlJaLT/+09zJp+rARqqETLYExZGutAYlmEiNYdijhxBIzTZBAZ5oJF6QVYa6UJjuUHpLJSDhl2EgRiZobE6cqVrTBRhIEZmaJz8KA8adhEGcmSGxo/3M0Ejm/NoikGjd7ELNFQjDAXJDI2T8zVAwyzCVgnPXJZHurrGsAwTqTkMGmR0OjdoBCUzNwCN/pFONK6b5rfr2hfKc7p0rBg0vvzy7+Z3edCwjbBTKWisf5T/rfof5XNCI90V2T0jZ4tGXncwKASN9nq1QVmdzQMaphEOVAoa7bfVskYPGRWgkdvdkpLcaa5/pBONQRkmUnMAjTiDuaKR3Z0ZC0DjaZW88oXy7NBIci/s/pGurnG9gqL3p3nDRGoOoBFn4ELj5K48oGER4ViTP5JlaOQ80cjxiRMloPG0Qal4XQM0PEa60Nisa/Sd6mWYSM2hNDSmfjLg4EgnGrUrz0+bZ6qZrWvk+eCzOrqGYSI1B9kg1ydpTvnsco+RoJEkglOg4ZnMzCDbp3aDhmcyMwPQ8Bs5PzS8yQAN0Jg8gqTTaKBh4SAY+JMBGqAxdQRRoOGXzMggZzROw4GGhYPbIIAM0ACNiSP06TgeaFg4OA1CyAAN0Jg2Qq9AwyeZhUEQGUnm5SghaFg4gEacwbzQCCMjzbx0M4KGhQNoxBnMCo1AMhLNSyclaFg4gEacwZzQCCUDNEBjugg+Ag1zB9CIM5gRGsFkpJqXw6CgYeFQLBqHSUHDwuHIIJwM0JgHGiPISDcv+7CgYeEAGnEGc0FjDBkJ52UXFzQsHEpGY5cXNCwcDg1GkQEanmjcLBaLF1dlojGOjJTz8hS5CDQu35XbNQpEY5u5BDQeP14Ui8ZIMkDDD42Ht8sNyrpxPFtqsMdkpUzvhNSvbEIPBrl/fXHQOQxhVXMovGtsUpfQNdba7W8YJlJz2BmMJSMxGuvcoGHh8GQwmozUaKySl4DG3cvb9vFTgQev48lIjsYyewlorNY1zncHKYaJ1BwqQONrUwQaHRkmUnPYGESQkQEaUfEjI9SORlRpQaNiNOIqCxqgYRkh0iGWDdAQDMpHI7ZvgIbbIFlZtQziPwRoOA3SNWMtg/jWBxoug4S7cFoG8YdZoOFQNBmgUSka8QuJ2aCRZkUXNAwjgIZuIiUHhV+m8kEjya/HoGEXATSUE+k4aJzqkBEaKU5HqhQNlROkckIjwUmMdaKhc1olaNSHhtJ5+lmhMf21NDWioXXhV15oTH5xZoVoqF0uChqgoR5BzaDjMPHV/vWhoXdrCtCoCw3FG9qARlVoaN4hLTc0Jr7pVGVoqN5yMzs0pr2LYV1o6N6oFzTqQUP5USL5oTHpbXFrQqOpH40p77NeERrqDzsEjTFoZKjyP4GXpv+YxXeN069TlV1jwufH1YKGo2CgERehEjRc9QKNuAh1oOEsV6VoTPYYY9BQimBj4HQIYmPmaLhrVS0aQWzMGo1GqFS9aISwMWc0xDJVjEYAGzNGQy4SaMRFKB2NnhrVjIY/G6CRMIKlgezgy8Zc0ZD2QCeMYGvQg4YnGzNFo786daPh2zdmicbQ96Z2NPzYmCMag4WpHg0vNmaIxvC2tn40fHY45oeGxxdmBmh4lGFuaHjtns8BjeFKzAsNz+O2WaAxWI0ZodH4HtDPBQ2z1Z2y0PDnwizCtAZ+DnNHo2mCwJgTGn19o3I0gqnQj5DIwP/UBKk+1aLRjKNCM0JSgwAHoUwVohEDhVKEstAQ4KgMjTUUhc1LFhEccNSDxr5XFDcvWUQ46bRVoHG0BSlwXrKIcARH6Wi49iuKnJc8IhxWs2A0xL3NUucljwgK2+WEaAwcgxQ8L5lEiNyb90fj4e3i5a0KGo3XgWnh85JJhJh1IV80Hj+8a29+jUKj8WOixyFI6eclkwhBZT8Y6YvGw19X7f2bqzA0mo6CP1Oc8piX1A47g6ZH7pG+aNz/fts+/HmxfPVsKfd7Tv6XQ6aoAA3O4t3LJzRWsqe9rq9siRG80dh3DdCYRwRvNEbta8Ro3vOSQQRvNB4//BF7hBKYLLnBzCN4o6G4ruGZLLnBzCP4o9GRYSI1ByLEGYAGEaSRoEEEYSRoEEEYCRpEEEaCBhGEkaBBBGHkODQGJfwAN6WIoBMBNIggCDSIIAg0iCCIs26QINBAgkADCQINJAg0kCAVNPZn+2xfdU7/mUQnEW4Wi8WLq4FRRhHazSmTKauwjRBTBQ009lcxbV91L2uaQicR2st3U/7/2+61XHer+UhZhW2EqCpooLE/s3j7qnuq8RQ6ifD48WJwkFWE9vL88/JFyipsI0RVQQON/fUI21fdCxSm0EmEZWtdLCZtHJ0PvZqglFXYRoiqggYa+6uYtq+6lzVNoZMI968v4r4zERHazbykrMI2QlQVau0a679Our+RY9dYa2wVat3XWP91UjQ6H/o+9b5GJmjsr2Lavupe1jSFTiKseuvjpynnpfOhV/OSsgrtfps2ugqK6xrb/Z6U6xoHEZZH9OfTHqTsIyRe1ziIEFMFVkORINBAgkADCQINJAg0kCDQQIJAAwkCDSQINJAg0ECCQAMJAg0kCDSQINBAgkADCQINJAg0evXj/fPUEZIJNJAg0ECCQAMJAg0kCDSQINBAgkADCQINJAg0kCDQQIL+Dx0tP4AdSptIAAAAAElFTkSuQmCC" />

<!-- rnb-plot-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Observamos que, exceptuando d3, d5 y edad, se acercan bastante a las normalidad. Probamos una transformación en estas variables. **¿Es posible que este modelo sea robusto a la falta de normalidad?**


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYgJT4lIFxuICBzZWxlY3QoZDMsIGQ1LCBlZGFkKSAlPiUgXG4gIG11dGF0ZShsbl9kMyA9IGxvZyhkMywgZXhwKDEpKSxcbiAgICAgICAgIGxuX2Q1ID0gbG9nKGQ1LCBleHAoMSkpLFxuICAgICAgICAgbG5fZWRhZCA9IGxvZyhlZGFkLCBleHAoMSkpKSAlPiUgXG4gIGdncGxvdCgpICtcbiAgZ2VvbV9kZW5zaXR5KGFlcyhsbl9kMyksIGNvbG9yID0gXCJyZWRcIikgK1xuICBnZW9tX2RlbnNpdHkoYWVzKGxuX2Q1KSwgY29sb3IgPSBcImJsdWVcIikgK1xuICBnZW9tX2RlbnNpdHkoYWVzKGxuX2VkYWQpLCBjb2xvciA9IFwiZ3JlZW5cIikgXG5gYGAifQ== -->

```r
df %>% 
  select(d3, d5, edad) %>% 
  mutate(ln_d3 = log(d3, exp(1)),
         ln_d5 = log(d5, exp(1)),
         ln_edad = log(edad, exp(1))) %>% 
  ggplot() +
  geom_density(aes(ln_d3), color = "red") +
  geom_density(aes(ln_d5), color = "blue") +
  geom_density(aes(ln_edad), color = "green") 
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Observamos que las varibles adpotan una forma más semejante a una normal con esta transformación.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGYyIDwtIGRmICU+JSBcbiAgbXV0YXRlKGxuX2QzID0gbG9nKGQzLCBleHAoMSkpLFxuICAgICAgICAgbG5fZDUgPSBsb2coZDUsIGV4cCgxKSksXG4gICAgICAgICBsbl9lZGFkID0gbG9nKGVkYWQsIGV4cCgxKSkpXG5cbnZhcl9udW1lcmljYXMgPC0gYyhcImQxXCIsICBcImQyXCIsIFwibG5fZDNcIiwgXCJkNFwiLCBcImxuX2Q1XCIsIFwibG5fZWRhZFwiKVxuYGBgIn0= -->

```r
df2 <- df %>% 
  mutate(ln_d3 = log(d3, exp(1)),
         ln_d5 = log(d5, exp(1)),
         ln_edad = log(edad, exp(1)))

var_numericas <- c("d1",  "d2", "ln_d3", "d4", "ln_d5", "ln_edad")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Para las variables categóricas vamos a utilizar


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudmFyX2NhdGVnIDwtIGMoXCJlZHVjXCIsIFwiZW1wbGVvXCIsICBcImdlbmVyb1wiLCAgXCJlc3RhZG9fbWFyaXRhbFwiLCAgXCJmYWNpbGlkYWRfY2VsdWxhclwiLCBcImZ1bW9cIilcbmBgYCJ9 -->

```r
var_categ <- c("educ", "empleo",  "genero",  "estado_marital",  "facilidad_celular", "fumo")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


**¿Cómo se podría ver si son independientes las va categóricas?**


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBOb3MgcXVlZGFtb3MgY29uIGxhcyB2YWlhYmxlcyBxdWUgcXVlcmVtb3NcblxudmFyaWFibGVzIDwtIGModmFyX251bWVyaWNhcywgdmFyX2NhdGVnLCBcImRpYWdub3N0aWNvX3Byb1wiKVxuXG5kZl9iYXllcyA8LSBkZjIgJT4lIFxuICBzZWxlY3QoYWxsX29mKHZhcmlhYmxlcykpXG5cbiMgRGl2aWRpbW9zIGVsIGRhdGFzdGVcblxuc2V0LnNlZWQoMTAwKVxuaW5kaWNlc190cmFpbiA8LSBjcmVhdGVEYXRhUGFydGl0aW9uKGRmX2JheWVzJGRpYWdub3N0aWNvX3BybywgcCA9IC43LCBsaXN0ID0gRkFMU0UpXG5kYXRvc190cmFpbiA8LSBkZl9iYXllc1tpbmRpY2VzX3RyYWluLCBdXG5kYXRvc190ZXN0IDwtIGRmX2JheWVzWy1pbmRpY2VzX3RyYWluLCBdXG5cbiMgQ3JlYW1vcyBlbCBtb2RlbG9cblxubW9kZWxvX2JheWVzIDwtIG5haXZlQmF5ZXMoZGlhZ25vc3RpY29fcHJvIH4gLiwgZGF0YSA9IGRhdG9zX3RyYWluKVxubW9kZWxvX2JheWVzXG5gYGAifQ== -->

```r
# Nos quedamos con las vaiables que queremos

variables <- c(var_numericas, var_categ, "diagnostico_pro")

df_bayes <- df2 %>% 
  select(all_of(variables))

# Dividimos el dataste

set.seed(100)
indices_train <- createDataPartition(df_bayes$diagnostico_pro, p = .7, list = FALSE)
datos_train <- df_bayes[indices_train, ]
datos_test <- df_bayes[-indices_train, ]

# Creamos el modelo

modelo_bayes <- naiveBayes(diagnostico_pro ~ ., data = datos_train)
modelo_bayes
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG5OYWl2ZSBCYXllcyBDbGFzc2lmaWVyIGZvciBEaXNjcmV0ZSBQcmVkaWN0b3JzXG5cbkNhbGw6XG5uYWl2ZUJheWVzLmRlZmF1bHQoeCA9IFgsIHkgPSBZLCBsYXBsYWNlID0gbGFwbGFjZSlcblxuQS1wcmlvcmkgcHJvYmFiaWxpdGllczpcbllcbiAgICBmYWxzZSAgICAgIHRydWUgXG4wLjU3NjMwMzkgMC40MjM2OTYxIFxuXG5Db25kaXRpb25hbCBwcm9iYWJpbGl0aWVzOlxuICAgICAgIGQxXG5ZICAgICAgICAgICBbLDFdICAgICBbLDJdXG4gIGZhbHNlIDI2LjM0Mjk3IDQuNDg3ODI2XG4gIHRydWUgIDI5LjA1Njc1IDUuMDQ5ODgzXG5cbiAgICAgICBkMlxuWSAgICAgICAgICAgICBbLDFdICAgICBbLDJdXG4gIGZhbHNlICAtOS43NTUxMTggMjMuNzM1NTlcbiAgdHJ1ZSAgLTE2LjcxNjI0NSAzMC4xNDc1N1xuXG4gICAgICAgbG5fZDNcblkgICAgICAgICAgICBbLDFdICAgICAgWywyXVxuICBmYWxzZSAtMS43MzYyNTcgMC43NDYwNzAzXG4gIHRydWUgIC0xLjY0MzgyNiAwLjc1NjA4NDJcblxuICAgICAgIGQ0XG5ZICAgICAgICAgICAgIFssMV0gICAgICAgWywyXVxuICBmYWxzZSAwLjA4NTEyODA4IDAuMDIxNzk4NjZcbiAgdHJ1ZSAgMC4wOTA5MDA5OCAwLjAyMjY0MDQ1XG5cbiAgICAgICBsbl9kNVxuWSAgICAgICAgICAgIFssMV0gICAgICBbLDJdXG4gIGZhbHNlIC00LjQ0OTgxNyAwLjg1MTQyNTdcbiAgdHJ1ZSAgLTQuNDYyMDkwIDAuODk5Mzk2M1xuXG4gICAgICAgbG5fZWRhZFxuWSAgICAgICAgICAgWywxXSAgICAgIFssMl1cbiAgZmFsc2UgMy44NDU2MzQgMC4yMTUyNTMwXG4gIHRydWUgIDQuMTA1MjMzIDAuMTY4MTIzNlxuXG4gICAgICAgZWR1Y1xuWSAgICAgICAyLXllYXIgY29sbGVnZSBkZWdyZWUgNC15ZWFyIGNvbGxlZ2UgZGVncmVlIERvY3RvcmFsIERlZ3JlZVxuICBmYWxzZSAgICAgICAgICAgMC4wNjcyNjQ1NzQgICAgICAgICAgIDAuMjY0NTczOTkxICAgICAwLjEyNjY4MTYxNFxuICB0cnVlICAgICAgICAgICAgMC4wNTMxOTE0ODkgICAgICAgICAgIDAuMjY0NDM3NjkwICAgICAwLjE0NTg5NjY1N1xuICAgICAgIGVkdWNcblkgICAgICAgSGlnaCBTY2hvb2wgRGlwbG9tYS9HRUQgTWFzdGVycyBEZWdyZWUgU29tZSBjb2xsZWdlIFNvbWUgZ3JhZHVhdGUgc2Nob29sXG4gIGZhbHNlICAgICAgICAgICAgIDAuMDQ0ODQzMDQ5ICAgIDAuMjQxMDMxMzkwICAwLjE2OTI4MjUxMSAgICAgICAgICAwLjA3NjIzMzE4NFxuICB0cnVlICAgICAgICAgICAgICAwLjA2NTM0OTU0NCAgICAwLjI1ODM1ODY2MyAgMC4xMzY3NzgxMTYgICAgICAgICAgMC4wNzI5NDgzMjhcbiAgICAgICBlZHVjXG5ZICAgICAgIFNvbWUgaGlnaCBzY2hvb2xcbiAgZmFsc2UgICAgICAwLjAxMDA4OTY4NlxuICB0cnVlICAgICAgIDAuMDAzMDM5NTE0XG5cbiAgICAgICBlbXBsZW9cblkgICAgICAgQSBob21lbWFrZXIgICBBIHN0dWRlbnQgRW1wbG95bWVudCBmb3Igd2FnZXMgT3V0IG9mIHdvcmsgICAgIFJldGlyZWRcbiAgZmFsc2UgMC4wMTQ1NTc2NzEgMC4wMDU1OTkxMDQgICAgICAgICAgMC42Njk2NTI4NTYgMC4wMzY5NTQwODcgMC4wOTk2NjQwNTRcbiAgdHJ1ZSAgMC4wMTgyOTI2ODMgMC4wMDAwMDAwMDAgICAgICAgICAgMC4yODUwNjA5NzYgMC4wMDQ1NzMxNzEgMC40NTEyMTk1MTJcbiAgICAgICBlbXBsZW9cblkgICAgICAgU2VsZi1lbXBsb3llZCBVbmFibGUgdG8gd29ya1xuICBmYWxzZSAgIDAuMTYwMTM0Mzc4ICAgIDAuMDEzNDM3ODUwXG4gIHRydWUgICAgMC4xNDE3NjgyOTMgICAgMC4wOTkwODUzNjZcblxuICAgICAgIGdlbmVyb1xuWSAgICAgICAgICAgIEZlbWFsZSAgICAgICAgTWFsZSBQcmVmZXIgbm90IHRvIGFuc3dlclxuICBmYWxzZSAwLjE4MjEyMjkwNSAwLjgxNjc1OTc3NyAgICAgICAgICAwLjAwMTExNzMxOFxuICB0cnVlICAwLjM1MDA3NjEwNCAwLjY0OTkyMzg5NiAgICAgICAgICAwLjAwMDAwMDAwMFxuXG4gICAgICAgZXN0YWRvX21hcml0YWxcblkgICAgICAgICAgRGl2b3JjZWQgTWFycmllZCBvciBkb21lc3RpYyBwYXJ0bmVyc2hpcCAgICAgICBPdGhlciAgIFNlcGFyYXRlZFxuICBmYWxzZSAwLjA4NTAxMTE4NiAgICAgICAgICAgICAgICAgICAgIDAuNzQyNzI5MzA2IDAuMDAzMzU1NzA1IDAuMDEzNDIyODE5XG4gIHRydWUgIDAuMDkyNzA1MTY3ICAgICAgICAgICAgICAgICAgICAgMC44MDg1MTA2MzggMC4wMDkxMTg1NDEgMC4wMDkxMTg1NDFcbiAgICAgICBlc3RhZG9fbWFyaXRhbFxuWSAgICAgICBTaW5nbGUgbmV2ZXIgbWFycmllZCAgICAgV2lkb3dlZFxuICBmYWxzZSAgICAgICAgICAwLjE0MjA1ODE2NiAwLjAxMzQyMjgxOVxuICB0cnVlICAgICAgICAgICAwLjA0MjU1MzE5MSAwLjAzNzk5MzkyMVxuXG4gICAgICAgZmFjaWxpZGFkX2NlbHVsYXJcblkgICAgICAgICBEaWZmaWN1bHQgICAgICAgIEVhc3kgTmVpdGhlciBlYXN5IG5vciBkaWZmaWN1bHQgVmVyeSBEaWZmaWN1bHRcbiAgZmFsc2UgMC4wMDMzNTE5NTUgMC4wOTQ5NzIwNjcgICAgICAgICAgICAgICAgMC4wMDg5Mzg1NDcgICAgMC4wMDAwMDAwMDBcbiAgdHJ1ZSAgMC4wMjU4MzU4NjYgMC4zNDgwMjQzMTYgICAgICAgICAgICAgICAgMC4xNzc4MTE1NTAgICAgMC4wMDQ1NTkyNzFcbiAgICAgICBmYWNpbGlkYWRfY2VsdWxhclxuWSAgICAgICAgIFZlcnkgZWFzeVxuICBmYWxzZSAwLjg5MjczNzQzMFxuICB0cnVlICAwLjQ0Mzc2ODk5N1xuXG4gICAgICAgZnVtb1xuWSAgICAgICAgICAgZmFsc2UgICAgICB0cnVlXG4gIGZhbHNlIDAuNjI2OTAwNiAwLjM3MzA5OTRcbiAgdHJ1ZSAgMC42NTE0NDYwIDAuMzQ4NTU0MFxuIn0= -->

```

Naive Bayes Classifier for Discrete Predictors

Call:
naiveBayes.default(x = X, y = Y, laplace = laplace)

A-priori probabilities:
Y
    false      true 
0.5763039 0.4236961 

Conditional probabilities:
       d1
Y           [,1]     [,2]
  false 26.34297 4.487826
  true  29.05675 5.049883

       d2
Y             [,1]     [,2]
  false  -9.755118 23.73559
  true  -16.716245 30.14757

       ln_d3
Y            [,1]      [,2]
  false -1.736257 0.7460703
  true  -1.643826 0.7560842

       d4
Y             [,1]       [,2]
  false 0.08512808 0.02179866
  true  0.09090098 0.02264045

       ln_d5
Y            [,1]      [,2]
  false -4.449817 0.8514257
  true  -4.462090 0.8993963

       ln_edad
Y           [,1]      [,2]
  false 3.845634 0.2152530
  true  4.105233 0.1681236

       educ
Y       2-year college degree 4-year college degree Doctoral Degree
  false           0.067264574           0.264573991     0.126681614
  true            0.053191489           0.264437690     0.145896657
       educ
Y       High School Diploma/GED Masters Degree Some college Some graduate school
  false             0.044843049    0.241031390  0.169282511          0.076233184
  true              0.065349544    0.258358663  0.136778116          0.072948328
       educ
Y       Some high school
  false      0.010089686
  true       0.003039514

       empleo
Y       A homemaker   A student Employment for wages Out of work     Retired
  false 0.014557671 0.005599104          0.669652856 0.036954087 0.099664054
  true  0.018292683 0.000000000          0.285060976 0.004573171 0.451219512
       empleo
Y       Self-employed Unable to work
  false   0.160134378    0.013437850
  true    0.141768293    0.099085366

       genero
Y            Female        Male Prefer not to answer
  false 0.182122905 0.816759777          0.001117318
  true  0.350076104 0.649923896          0.000000000

       estado_marital
Y          Divorced Married or domestic partnership       Other   Separated
  false 0.085011186                     0.742729306 0.003355705 0.013422819
  true  0.092705167                     0.808510638 0.009118541 0.009118541
       estado_marital
Y       Single never married     Widowed
  false          0.142058166 0.013422819
  true           0.042553191 0.037993921

       facilidad_celular
Y         Difficult        Easy Neither easy nor difficult Very Difficult
  false 0.003351955 0.094972067                0.008938547    0.000000000
  true  0.025835866 0.348024316                0.177811550    0.004559271
       facilidad_celular
Y         Very easy
  false 0.892737430
  true  0.443768997

       fumo
Y           false      true
  false 0.6269006 0.3730994
  true  0.6514460 0.3485540
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Ahora que tenemos el modelo, comenzamos realizando las predicciones


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJlZGljY2lvbmVzX2JheWVzIDwtIHByZWRpY3QobW9kZWxvX2JheWVzLCBkYXRvc190ZXN0LCB0eXBlID0gXCJyYXdcIilcbm9iamV0b19yb2MgPC0gcm9jKGRhdG9zX3Rlc3QkZGlhZ25vc3RpY29fcHJvLCBwcmVkaWNjaW9uZXNfYmF5ZXNbLFwidHJ1ZVwiXSlcbmBgYCJ9 -->

```r
predicciones_bayes <- predict(modelo_bayes, datos_test, type = "raw")
objeto_roc <- roc(datos_test$diagnostico_pro, predicciones_bayes[,"true"])
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiU2V0dGluZyBsZXZlbHM6IGNvbnRyb2wgPSBmYWxzZSwgY2FzZSA9IHRydWVcblNldHRpbmcgZGlyZWN0aW9uOiBjb250cm9scyA8IGNhc2VzXG4ifQ== -->

```
Setting levels: control = false, case = true
Setting direction: controls < cases
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGF0YS5mcmFtZShzZW5zaXRpdml0eSA9IG9iamV0b19yb2Mkc2Vuc2l0aXZpdGllcyxcbiAgICAgICAgICAgc3BlY2lmaWNpdHkgPSBvYmpldG9fcm9jJHNwZWNpZmljaXRpZXMpICU+JSBcbiAgZ2dwbG90KGFlcygxIC0gc3BlY2lmaWNpdHksIHNlbnNpdGl2aXR5KSkgK1xuICBnZW9tX2xpbmUoKVxuYGBgIn0= -->

```r
data.frame(sensitivity = objeto_roc$sensitivities,
           specificity = objeto_roc$specificities) %>% 
  ggplot(aes(1 - specificity, sensitivity)) +
  geom_line()
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjMzMi41MDkzLCJ3aWR0aCI6NTM4LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5hdWMob2JqZXRvX3JvYylcbmBgYCJ9 -->

```r

auc(objeto_roc)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiQXJlYSB1bmRlciB0aGUgY3VydmU6IDAuODU3N1xuIn0= -->

```
Area under the curve: 0.8577
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Observamos que este modelo consigue un buen valor de AUC. Para seguir, vamos a armar rapidamente una regresión logística usando las mismas variables, para luego comparar ambos modelos.

Como la regresión logística no pone ninguna restrcción sobre las variables independientes, vamos a usar más variables, primero veamos cuales tienen mayor cantidad de NAs


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG4jIE9ic2VhcnZhbW9zIGxhIGNhbnRpZGFkIGRlIE5Bc1xuZGYgJT4lXG4gIG1hcF9pbnQofiBzdW0oaXMubmEoLikpKVxuYGBgIn0= -->

```r

# Obsearvamos la cantidad de NAs
df %>%
  map_int(~ sum(is.na(.)))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgICAgICAgICAgICAgICBkMSAgICAgICAgICAgICAgICAgICAgIGQyICAgICAgICAgICAgICAgICAgICAgZDMgXG4gICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAgICAgMCBcbiAgICAgICAgICAgICAgICAgICAgZDQgICAgICAgICAgICAgICAgICAgICBkNSAgICAgICAgICAgICAgICAgICBlZGFkIFxuICAgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgIDAgXG4gICAgICAgICAgIGVzX2N1aWRhZG9yICAgICAgICAgICAgICAgICAgICBkYnMgICAgICAgYW5pb19kaWFnbm9zdGljbyBcbiAgICAgICAgICAgICAgICAgICAgIDMgICAgICAgICAgICAgICAgICAgIDI2OCAgICAgICAgICAgICAgICAgICAxMjg3IFxuICAgICAgICAgICAgICAgICAgZWR1YyAgICAgICAgICAgICAgICAgZW1wbGVvICAgICAgICAgICAgICAgICBnZW5lcm8gXG4gICAgICAgICAgICAgICAgICAgICA3ICAgICAgICAgICAgICAgICAgICAgIDggICAgICAgICAgICAgICAgICAgICAgMiBcbiAgICAgICAgICAgdGlwb19tZWRpY28gICAgICAgICBlc3RhZG9fbWFyaXRhbCAgICAgIGFuaW9fY29taWVuem9fbWVkIFxuICAgICAgICAgICAgICAgICAgMTA3MyAgICAgICAgICAgICAgICAgICAgICA0ICAgICAgICAgICAgICAgICAgIDEzNTcgXG5hbmlvX2NvbWllbnpvX3NpbnRvbWFzICAgICAgIHBhcXVldGVzX3Bvcl9kaWEgICAgICBmYWNpbGlkYWRfY2VsdWxhciBcbiAgICAgICAgICAgICAgICAgIDExMjAgICAgICAgICAgICAgICAgICAgMTU2OSAgICAgICAgICAgICAgICAgICAgICAxIFxuICAgICAgICAgICAgICAgICAgZnVtbyAgICAgICAgICAgICAgICBjaXJ1Z2lhICAgICAgICAgICB2aWRlb2xsYW1hZGEgXG4gICAgICAgICAgICAgICAgICAgIDY1ICAgICAgICAgICAgICAgICAgICAzODMgICAgICAgICAgICAgICAgICAgICAgNCBcbiAgICAgICAgICAgIGFuaW9zX2Z1bW8gICAgICAgIGRpYWdub3N0aWNvX3BybyBcbiAgICAgICAgICAgICAgICAgIDE0NzEgICAgICAgICAgICAgICAgICAgICAgMCBcbiJ9 -->

```
                    d1                     d2                     d3 
                     0                      0                      0 
                    d4                     d5                   edad 
                     0                      0                      0 
           es_cuidador                    dbs       anio_diagnostico 
                     3                    268                   1287 
                  educ                 empleo                 genero 
                     7                      8                      2 
           tipo_medico         estado_marital      anio_comienzo_med 
                  1073                      4                   1357 
anio_comienzo_sintomas       paquetes_por_dia      facilidad_celular 
                  1120                   1569                      1 
                  fumo                cirugia           videollamada 
                    65                    383                      4 
            anios_fumo        diagnostico_pro 
                  1471                      0 
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBFbGVnaW1vcyBsYXMgdmFyaWFibGVzIGEgdXNhclxudmFyc19jdWFudGkgPC0gYyhcImQxXCIsIFwiZDJcIiwgXCJkM1wiLCBcImQ0XCIsIFwiZDVcIiwgXCJlZGFkXCIpXG52YXJzX2N1YWxpIDwtIGMoXCJlZHVjXCIsIFwiZW1wbGVvXCIsIFwiZ2VuZXJvXCIsIFwiZXN0YWRvX21hcml0YWxcIiwgXCJmYWNpbGlkYWRfY2VsdWxhclwiKVxudmFycyA8LSBjKHZhcnNfY3VhbnRpLCB2YXJzX2N1YWxpLCBcImRpYWdub3N0aWNvX3Byb1wiKVxuXG5kZl9sb2dpc3RpY2EgPC0gZGYgJT4lIFxuICBzZWxlY3QoYWxsX29mKHZhcnMpKSAlPiUgXG4gIGRyb3BfbmEoKVxuXG4jIMK/Q8O6YW50YXMgb2JzZXJ2YWNpb25lcyBub3MgcXVlZGFuP1xubnJvdyhkZl9sb2dpc3RpY2EpXG5gYGAifQ== -->

```r
# Elegimos las variables a usar
vars_cuanti <- c("d1", "d2", "d3", "d4", "d5", "edad")
vars_cuali <- c("educ", "empleo", "genero", "estado_marital", "facilidad_celular")
vars <- c(vars_cuanti, vars_cuali, "diagnostico_pro")

df_logistica <- df %>% 
  select(all_of(vars)) %>% 
  drop_na()

# ¿Cúantas observaciones nos quedan?
nrow(df_logistica)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDIyMDBcbiJ9 -->

```
[1] 2200
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBTZXBhcmFtb3MgbG9zIGRhdG9zXG5zZXQuc2VlZCg5OTkpXG5pbmRpY2VzX3RyYWluIDwtIGNyZWF0ZURhdGFQYXJ0aXRpb24oZGZfbG9naXN0aWNhJGRpYWdub3N0aWNvX3BybywgcCA9IC43LCBsaXN0ID0gRkFMU0UpXG5kYXRvc190cmFpbiA8LSBkZl9sb2dpc3RpY2FbaW5kaWNlc190cmFpbixdXG5kYXRvc190ZXN0IDwtIGRmX2xvZ2lzdGljYVstaW5kaWNlc190cmFpbixdXG5gYGAifQ== -->

```r
# Separamos los datos
set.seed(999)
indices_train <- createDataPartition(df_logistica$diagnostico_pro, p = .7, list = FALSE)
datos_train <- df_logistica[indices_train,]
datos_test <- df_logistica[-indices_train,]
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Con esto armado, vamos a entrenar el modelo


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubW9kZWxvIDwtIHRyYWluKGRpYWdub3N0aWNvX3BybyB+IC4sXG4gICAgICAgICAgICAgICAgZGF0YSA9IGRmX2xvZ2lzdGljYSxcbiAgICAgICAgICAgICAgICBtZXRob2QgPSBcImdsbVwiLFxuICAgICAgICAgICAgICAgIGZhbWlseSA9IFwiYmlub21pYWxcIilcbmBgYCJ9 -->

```r
modelo <- train(diagnostico_pro ~ .,
                data = df_logistica,
                method = "glm",
                family = "binomial")
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoicHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5ncHJlZGljdGlvbiBmcm9tIGEgcmFuay1kZWZpY2llbnQgZml0IG1heSBiZSBtaXNsZWFkaW5nXG4ifQ== -->

```
prediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleadingprediction from a rank-deficient fit may be misleading
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Buscando en internet encontre que este problema puede deberse a que son desbalanceados los niveles de las distintas variables categóricas, vamos a armar unas tablas de frecuencias para ver si esto es verdad


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYXJtYXJfdGFibGFfZnJlY3VlbmNpYShkZl9sb2dpc3RpY2EsIHZhcnNfY3VhbGkpXG5gYGAifQ== -->

```r
armar_tabla_frecuencia(df_logistica, vars_cuali)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiJGVkdWNcblxuICAyLXllYXIgY29sbGVnZSBkZWdyZWUgICA0LXllYXIgY29sbGVnZSBkZWdyZWUgICAgICAgICBEb2N0b3JhbCBEZWdyZWUgXG4gICAgICAgICAgICAgICAgICAgIDEzNyAgICAgICAgICAgICAgICAgICAgIDU3MyAgICAgICAgICAgICAgICAgICAgIDI5MiBcbkhpZ2ggU2Nob29sIERpcGxvbWEvR0VEICAgICAgICAgIE1hc3RlcnMgRGVncmVlICAgICAgICAgICAgU29tZSBjb2xsZWdlIFxuICAgICAgICAgICAgICAgICAgICAxMTUgICAgICAgICAgICAgICAgICAgICA1NTMgICAgICAgICAgICAgICAgICAgICAzNDQgXG4gICBTb21lIGdyYWR1YXRlIHNjaG9vbCAgICAgICAgU29tZSBoaWdoIHNjaG9vbCBcbiAgICAgICAgICAgICAgICAgICAgMTcxICAgICAgICAgICAgICAgICAgICAgIDE1IFxuXG4kZW1wbGVvXG5cbiAgICAgICAgIEEgaG9tZW1ha2VyICAgICAgICAgICAgQSBzdHVkZW50IEVtcGxveW1lbnQgZm9yIHdhZ2VzICAgICAgICAgIE91dCBvZiB3b3JrIFxuICAgICAgICAgICAgICAgICAgMzQgICAgICAgICAgICAgICAgICAgMTAgICAgICAgICAgICAgICAgIDExMTUgICAgICAgICAgICAgICAgICAgNTcgXG4gICAgICAgICAgICAgUmV0aXJlZCAgICAgICAgU2VsZi1lbXBsb3llZCAgICAgICBVbmFibGUgdG8gd29yayBcbiAgICAgICAgICAgICAgICAgNTM3ICAgICAgICAgICAgICAgICAgMzI4ICAgICAgICAgICAgICAgICAgMTE5IFxuXG4kZ2VuZXJvXG5cbiAgICAgICAgICAgICAgRmVtYWxlICAgICAgICAgICAgICAgICBNYWxlIFByZWZlciBub3QgdG8gYW5zd2VyIFxuICAgICAgICAgICAgICAgICA1NzIgICAgICAgICAgICAgICAgIDE2MjcgICAgICAgICAgICAgICAgICAgIDEgXG5cbiRlc3RhZG9fbWFyaXRhbFxuXG4gICAgICAgICAgICAgICAgICAgICAgIERpdm9yY2VkIE1hcnJpZWQgb3IgZG9tZXN0aWMgcGFydG5lcnNoaXAgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgMTgyICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE3MjEgXG4gICAgICAgICAgICAgICAgICAgICAgICAgIE90aGVyICAgICAgICAgICAgICAgICAgICAgICBTZXBhcmF0ZWQgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjcgXG4gICAgICAgICAgIFNpbmdsZSBuZXZlciBtYXJyaWVkICAgICAgICAgICAgICAgICAgICAgICAgIFdpZG93ZWQgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgMjA5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTAgXG5cbiRmYWNpbGlkYWRfY2VsdWxhclxuXG4gICAgICAgICAgICAgICAgIERpZmZpY3VsdCAgICAgICAgICAgICAgICAgICAgICAgRWFzeSBOZWl0aGVyIGVhc3kgbm9yIGRpZmZpY3VsdCBcbiAgICAgICAgICAgICAgICAgICAgICAgIDM0ICAgICAgICAgICAgICAgICAgICAgICAgNDMwICAgICAgICAgICAgICAgICAgICAgICAgMTc1IFxuICAgICAgICAgICAgVmVyeSBEaWZmaWN1bHQgICAgICAgICAgICAgICAgICBWZXJ5IGVhc3kgXG4gICAgICAgICAgICAgICAgICAgICAgICAgOCAgICAgICAgICAgICAgICAgICAgICAgMTU1MyBcbiJ9 -->

```
$educ

  2-year college degree   4-year college degree         Doctoral Degree 
                    137                     573                     292 
High School Diploma/GED          Masters Degree            Some college 
                    115                     553                     344 
   Some graduate school        Some high school 
                    171                      15 

$empleo

         A homemaker            A student Employment for wages          Out of work 
                  34                   10                 1115                   57 
             Retired        Self-employed       Unable to work 
                 537                  328                  119 

$genero

              Female                 Male Prefer not to answer 
                 572                 1627                    1 

$estado_marital

                       Divorced Married or domestic partnership 
                            182                            1721 
                          Other                       Separated 
                             11                              27 
           Single never married                         Widowed 
                            209                              50 

$facilidad_celular

                 Difficult                       Easy Neither easy nor difficult 
                        34                        430                        175 
            Very Difficult                  Very easy 
                         8                       1553 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Observamos que evidentemente hay casos con estos problemas, vamso a solucionar creando nuevos niveles


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBEaXZpZGlyIGVkdWMgZW4gUG9zZ3JhZHVhdGUgLSBDb2xsZWdlIC0gSGlnaHNjaG9vbFxuZGZfbG9naXN0aWNhIDwtIGRmX2xvZ2lzdGljYSAlPiUgXG4gIG11dGF0ZShlZHVjID0gZmN0X2NvbGxhcHNlKGVkdWMsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcIlBvc3RncmFkdWF0ZVwiID0gYyhcIkRvY3RvcmFsIERlZ3JlZVwiLCBcIk1hc3RlcnMgRGVncmVlXCIpLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXCJDb2xsZWdlXCIgPSBjKFwiMi15ZWFyIGNvbGxlZ2UgZGVncmVlXCIsIFwiNC15ZWFyIGNvbGxlZ2UgZGVncmVlXCIsIFwiU29tZSBncmFkdWF0ZSBzY2hvb2xcIiksXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcIkhpZ2hTY2hvb2xcIiA9IGMoXCJIaWdoIFNjaG9vbCBEaXBsb21hL0dFRFwiLCBcIlNvbWUgY29sbGVnZVwiLCBcIlNvbWUgaGlnaCBzY2hvb2xcIikpKVxuXG4jIEVtcGxlbW9zIGxvIGFncnVwYW1vcyBlbiBXb3JraW5nIC0gTm90IFdvcmtpbmdcbmRmX2xvZ2lzdGljYSA8LSBkZl9sb2dpc3RpY2EgJT4lIFxuICBtdXRhdGUoZW1wbGVvID0gZmN0X2NvbGxhcHNlKGVtcGxlbywgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCJXb3JraW5nXCIgPSBjKFwiQSBob21lbWFrZXJcIiwgXCJFbXBsb3ltZW50IGZvciB3YWdlc1wiLCBcIlNlbGYtZW1wbG95ZWRcIiksXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCJOb3QgV29ya2luZ1wiID0gYyhcIkEgc3R1ZGVudFwiLCBcIk91dCBvZiB3b3JrXCIsIFwiUmV0aXJlZFwiLCBcIlVuYWJsZSB0byB3b3JrXCIgKSkpXG5cbiMgR2VuZXJvIHNhY2Ftb3MgbGEgb2JzZXJ2YWNpb24gY29uIFByZWZlciBub3QgdG8gYW5zd2VyXG5kZl9sb2dpc3RpY2EgPC0gZGZfbG9naXN0aWNhICU+JSBcbiAgZmlsdGVyKGdlbmVybyAhPSBcIlByZWZlciBub3QgdG8gYW5zd2VyXCIpXG5cbiMgRXN0YWRvIG1hcml0YWwgbG8gY29udmVydGltb3MgZW4gTWFycmllZCAtIE5vdCBNYXJyaWVkXG5kZl9sb2dpc3RpY2EgPC0gZGZfbG9naXN0aWNhICU+JSBcbiAgbXV0YXRlKGVzdGFkb19tYXJpdGFsID0gZmN0X2NvbGxhcHNlKGVzdGFkb19tYXJpdGFsLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCJNYXJyaWVkXCIgPSBjKFwiTWFycmllZCBvciBkb21lc3RpYyBwYXJ0bmVyc2hpcFwiKSxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwiTm90IE1hcnJpZWRcIiA9IGMoXCJEaXZvcmNlZFwiLCBcIk90aGVyXCIsIFwiU2VwYXJhdGVkXCIsIFwiU2luZ2xlIG5ldmVyIG1hcnJpZWRcIiwgXCJXaWRvd2VkXCIpKSlcblxuIyBQYXJhIGZhY2lsaWRhZCBjZWx1bGFyIGxvIGNvbnZlcnRpbW9zIGVuIEVhc3kgLSBOb3QgRWFzeVxuZGZfbG9naXN0aWNhIDwtIGRmX2xvZ2lzdGljYSAlPiUgXG4gIG11dGF0ZShmYWNpbGlkYWRfY2VsdWxhciA9IGZjdF9jb2xsYXBzZShmYWNpbGlkYWRfY2VsdWxhcixcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwiTm90IEVhc3lcIiA9IGMoXCJEaWZmaWN1bHRcIiwgXCJOZWl0aGVyIGVhc3kgbm9yIGRpZmZpY3VsdFwiLCBcIlZlcnkgRGlmZmljdWx0XCIpLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCJFYXN5XCIgPSBjKFwiRWFzeVwiLCBcIlZlcnkgZWFzeVwiKSkpXG5cbiMgUHJvYmFtb3MgbnVldmFtZW50ZSBwYXJhIHZlciBzaSBoYSBwb2NhcyBvYnNlcnZhY2lvbmVzIGVuIGFsZ8O6biBuaXZlbFxuYXJtYXJfdGFibGFfZnJlY3VlbmNpYShkZl9sb2dpc3RpY2EsIHZhcnNfY3VhbGkpXG5gYGAifQ== -->

```r
# Dividir educ en Posgraduate - College - Highschool
df_logistica <- df_logistica %>% 
  mutate(educ = fct_collapse(educ,
                           "Postgraduate" = c("Doctoral Degree", "Masters Degree"),
                           "College" = c("2-year college degree", "4-year college degree", "Some graduate school"),
                           "HighSchool" = c("High School Diploma/GED", "Some college", "Some high school")))

# Emplemos lo agrupamos en Working - Not Working
df_logistica <- df_logistica %>% 
  mutate(empleo = fct_collapse(empleo, 
                               "Working" = c("A homemaker", "Employment for wages", "Self-employed"),
                               "Not Working" = c("A student", "Out of work", "Retired", "Unable to work" )))

# Genero sacamos la observacion con Prefer not to answer
df_logistica <- df_logistica %>% 
  filter(genero != "Prefer not to answer")

# Estado marital lo convertimos en Married - Not Married
df_logistica <- df_logistica %>% 
  mutate(estado_marital = fct_collapse(estado_marital,
                                       "Married" = c("Married or domestic partnership"),
                                       "Not Married" = c("Divorced", "Other", "Separated", "Single never married", "Widowed")))

# Para facilidad celular lo convertimos en Easy - Not Easy
df_logistica <- df_logistica %>% 
  mutate(facilidad_celular = fct_collapse(facilidad_celular,
                                    "Not Easy" = c("Difficult", "Neither easy nor difficult", "Very Difficult"),
                                    "Easy" = c("Easy", "Very easy")))

# Probamos nuevamente para ver si ha pocas observaciones en algún nivel
armar_tabla_frecuencia(df_logistica, vars_cuali)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiJGVkdWNcblxuICAgICBDb2xsZWdlIFBvc3RncmFkdWF0ZSAgIEhpZ2hTY2hvb2wgXG4gICAgICAgICA4ODEgICAgICAgICAgODQ0ICAgICAgICAgIDQ3NCBcblxuJGVtcGxlb1xuXG4gICAgV29ya2luZyBOb3QgV29ya2luZyBcbiAgICAgICAxNDc2ICAgICAgICAgNzIzIFxuXG4kZ2VuZXJvXG5cbkZlbWFsZSAgIE1hbGUgXG4gICA1NzIgICAxNjI3IFxuXG4kZXN0YWRvX21hcml0YWxcblxuTm90IE1hcnJpZWQgICAgIE1hcnJpZWQgXG4gICAgICAgIDQ3OSAgICAgICAgMTcyMCBcblxuJGZhY2lsaWRhZF9jZWx1bGFyXG5cbk5vdCBFYXN5ICAgICBFYXN5IFxuICAgICAyMTcgICAgIDE5ODIgXG4ifQ== -->

```
$educ

     College Postgraduate   HighSchool 
         881          844          474 

$empleo

    Working Not Working 
       1476         723 

$genero

Female   Male 
   572   1627 

$estado_marital

Not Married     Married 
        479        1720 

$facilidad_celular

Not Easy     Easy 
     217     1982 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

Si bien observamos que existen varios niveles desbalanceados, todos poseen una cantidad de observaciones acpetables. Volvemos a intetar entrenar el modelo


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc3VtbWFyeShtb2RlbG9fbG9naXN0aWNhKVxuXG5gYGAifQ== -->

```r
summary(modelo_logistica)

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG5DYWxsOlxuTlVMTFxuXG5EZXZpYW5jZSBSZXNpZHVhbHM6IFxuICAgIE1pbiAgICAgICAxUSAgIE1lZGlhbiAgICAgICAzUSAgICAgIE1heCAgXG4tMy4yMDU4ICAtMC42ODEzICAtMC4zNzMxICAgMC43MjQ1ICAgMi4zMjQwICBcblxuQ29lZmZpY2llbnRzOlxuICAgICAgICAgICAgICAgICAgICAgICBFc3RpbWF0ZSBTdGQuIEVycm9yIHogdmFsdWUgUHIoPnx6fCkgICAgXG4oSW50ZXJjZXB0KSAgICAgICAgICAgLTYuMDE5MzM3ICAgMC44NDMxMjQgIC03LjEzOSA5LjM4ZS0xMyAqKipcbmQxICAgICAgICAgICAgICAgICAgICAgMC4wNzU5MDYgICAwLjAyMDEyMiAgIDMuNzcyIDAuMDAwMTYyICoqKlxuZDIgICAgICAgICAgICAgICAgICAgIC0wLjAwMjU3NSAgIDAuMDAyODIyICAtMC45MTIgMC4zNjE1OTAgICAgXG5kMyAgICAgICAgICAgICAgICAgICAgIDAuODI5MzY5ICAgMC41MTAwNTQgICAxLjYyNiAwLjEwMzk0MCAgICBcbmQ0ICAgICAgICAgICAgICAgICAgICAgMS45MTMwNzggICAzLjI5ODg2MiAgIDAuNTgwIDAuNTYxOTY4ICAgIFxuZDUgICAgICAgICAgICAgICAgICAgIC0wLjY5NzAwMyAgIDMuNDY5NzI0ICAtMC4yMDEgMC44NDA3OTEgICAgXG5lZGFkICAgICAgICAgICAgICAgICAgIDAuMDkxOTA4ICAgMC4wMDcwODggIDEyLjk2NiAgPCAyZS0xNiAqKipcbmVkdWNQb3N0Z3JhZHVhdGUgICAgICAtMC4xNjcyNTkgICAwLjE0NzYzMiAgLTEuMTMzIDAuMjU3MjM1ICAgIFxuZWR1Y0hpZ2hTY2hvb2wgICAgICAgIC0wLjI3NzY3NiAgIDAuMTg2NzM4ICAtMS40ODcgMC4xMzcwMTkgICAgXG5gZW1wbGVvTm90IFdvcmtpbmdgICAgIDAuNjExNDY5ICAgMC4xNTczMzAgICAzLjg4NyAwLjAwMDEwMiAqKipcbmdlbmVyb01hbGUgICAgICAgICAgICAtMC4xMjcyNjYgICAwLjIwNDExNyAgLTAuNjIzIDAuNTMyOTYwICAgIFxuZXN0YWRvX21hcml0YWxNYXJyaWVkICAwLjQwNDk2NCAgIDAuMTcwNDEyICAgMi4zNzYgMC4wMTc0ODMgKiAgXG5mYWNpbGlkYWRfY2VsdWxhckVhc3kgLTIuMjkxMTIzICAgMC4zMjI1MjMgIC03LjEwNCAxLjIxZS0xMiAqKipcbi0tLVxuU2lnbmlmLiBjb2RlczogIDAg4oCYKioq4oCZIDAuMDAxIOKAmCoq4oCZIDAuMDEg4oCYKuKAmSAwLjA1IOKAmC7igJkgMC4xIOKAmCDigJkgMVxuXG4oRGlzcGVyc2lvbiBwYXJhbWV0ZXIgZm9yIGJpbm9taWFsIGZhbWlseSB0YWtlbiB0byBiZSAxKVxuXG4gICAgTnVsbCBkZXZpYW5jZTogMjA5OS4yICBvbiAxNTM5ICBkZWdyZWVzIG9mIGZyZWVkb21cblJlc2lkdWFsIGRldmlhbmNlOiAxNDIwLjkgIG9uIDE1MjcgIGRlZ3JlZXMgb2YgZnJlZWRvbVxuQUlDOiAxNDQ2LjlcblxuTnVtYmVyIG9mIEZpc2hlciBTY29yaW5nIGl0ZXJhdGlvbnM6IDVcbiJ9 -->

```

Call:
NULL

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-3.2058  -0.6813  -0.3731   0.7245   2.3240  

Coefficients:
                       Estimate Std. Error z value Pr(>|z|)    
(Intercept)           -6.019337   0.843124  -7.139 9.38e-13 ***
d1                     0.075906   0.020122   3.772 0.000162 ***
d2                    -0.002575   0.002822  -0.912 0.361590    
d3                     0.829369   0.510054   1.626 0.103940    
d4                     1.913078   3.298862   0.580 0.561968    
d5                    -0.697003   3.469724  -0.201 0.840791    
edad                   0.091908   0.007088  12.966  < 2e-16 ***
educPostgraduate      -0.167259   0.147632  -1.133 0.257235    
educHighSchool        -0.277676   0.186738  -1.487 0.137019    
`empleoNot Working`    0.611469   0.157330   3.887 0.000102 ***
generoMale            -0.127266   0.204117  -0.623 0.532960    
estado_maritalMarried  0.404964   0.170412   2.376 0.017483 *  
facilidad_celularEasy -2.291123   0.322523  -7.104 1.21e-12 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 2099.2  on 1539  degrees of freedom
Residual deviance: 1420.9  on 1527  degrees of freedom
AIC: 1446.9

Number of Fisher Scoring iterations: 5
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Este es el primer modelo, donde incluimos todas las variables. En los resultados vemos que existen variables que no resultan significativas para el modelo. Aplicamos un metodo stepwise para seleccionar aquellas que son más importantes.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuIyBQYXJhIGVzdG8gbmVjZXNpdGFtb3MgbGEgYmlsYmlvdGVjYSBNQVNTXG5tb2RlbG9fbG9naXN0aWNhIDwtIHRyYWluKGRpYWdub3N0aWNvX3BybyB+IC4sXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEgPSBkYXRvc190cmFpbixcbiAgICAgICAgICAgICAgICAgICAgICAgICAgbWV0aG9kID0gXCJnbG1TdGVwQUlDXCIsXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGZhbWlseSA9IFwiYmlub21pYWxcIilcbmBgYCJ9 -->

```r
# Para esto necesitamos la bilbioteca MASS
modelo_logistica <- train(diagnostico_pro ~ .,
                          data = datos_train,
                          method = "glmStepAIC",
                          family = "binomial")
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiU3RhcnQ6ICBBSUM9MTM1Mi41MlxuLm91dGNvbWUgfiBkMSArIGQyICsgZDMgKyBkNCArIGQ1ICsgZWRhZCArIGVkdWNQb3N0Z3JhZHVhdGUgKyBcbiAgICBlZHVjSGlnaFNjaG9vbCArIGBlbXBsZW9Ob3QgV29ya2luZ2AgKyBnZW5lcm9NYWxlICsgZXN0YWRvX21hcml0YWxNYXJyaWVkICsgXG4gICAgZmFjaWxpZGFkX2NlbHVsYXJFYXN5XG5cbiAgICAgICAgICAgICAgICAgICAgICAgIERmIERldmlhbmNlICAgIEFJQ1xuLSBlZHVjUG9zdGdyYWR1YXRlICAgICAgIDEgICAxMzI2LjYgMTM1MC42XG4tIGQ0ICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMjYuNiAxMzUwLjZcbi0gZWR1Y0hpZ2hTY2hvb2wgICAgICAgICAxICAgMTMyNi44IDEzNTAuOFxuLSBnZW5lcm9NYWxlICAgICAgICAgICAgIDEgICAxMzI3LjIgMTM1MS4yXG4tIGQyICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMjcuMyAxMzUxLjNcbjxub25lPiAgICAgICAgICAgICAgICAgICAgICAgMTMyNi41IDEzNTIuNVxuLSBkNSAgICAgICAgICAgICAgICAgICAgIDEgICAxMzI4LjggMTM1Mi44XG4tIGQzICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMzIuOSAxMzU2Ljlcbi0gZXN0YWRvX21hcml0YWxNYXJyaWVkICAxICAgMTMzMy40IDEzNTcuNFxuLSBkMSAgICAgICAgICAgICAgICAgICAgIDEgICAxMzM2LjYgMTM2MC42XG4tIGBlbXBsZW9Ob3QgV29ya2luZ2AgICAgMSAgIDEzNDQuMiAxMzY4LjJcbi0gZmFjaWxpZGFkX2NlbHVsYXJFYXN5ICAxICAgMTQyNy4yIDE0NTEuMlxuLSBlZGFkICAgICAgICAgICAgICAgICAgIDEgICAxNTYxLjYgMTU4NS42XG5cblN0ZXA6ICBBSUM9MTM1MC41OVxuLm91dGNvbWUgfiBkMSArIGQyICsgZDMgKyBkNCArIGQ1ICsgZWRhZCArIGVkdWNIaWdoU2Nob29sICsgYGVtcGxlb05vdCBXb3JraW5nYCArIFxuICAgIGdlbmVyb01hbGUgKyBlc3RhZG9fbWFyaXRhbE1hcnJpZWQgKyBmYWNpbGlkYWRfY2VsdWxhckVhc3lcblxuICAgICAgICAgICAgICAgICAgICAgICAgRGYgRGV2aWFuY2UgICAgQUlDXG4tIGQ0ICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMjYuNyAxMzQ4Ljdcbi0gZWR1Y0hpZ2hTY2hvb2wgICAgICAgICAxICAgMTMyNy4xIDEzNDkuMVxuLSBnZW5lcm9NYWxlICAgICAgICAgICAgIDEgICAxMzI3LjMgMTM0OS4zXG4tIGQyICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMjcuNCAxMzQ5LjRcbjxub25lPiAgICAgICAgICAgICAgICAgICAgICAgMTMyNi42IDEzNTAuNlxuLSBkNSAgICAgICAgICAgICAgICAgICAgIDEgICAxMzI4LjggMTM1MC44XG4tIGQzICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMzMuMCAxMzU1LjBcbi0gZXN0YWRvX21hcml0YWxNYXJyaWVkICAxICAgMTMzMy40IDEzNTUuNFxuLSBkMSAgICAgICAgICAgICAgICAgICAgIDEgICAxMzM2LjcgMTM1OC43XG4tIGBlbXBsZW9Ob3QgV29ya2luZ2AgICAgMSAgIDEzNDQuMiAxMzY2LjJcbi0gZmFjaWxpZGFkX2NlbHVsYXJFYXN5ICAxICAgMTQyNy43IDE0NDkuN1xuLSBlZGFkICAgICAgICAgICAgICAgICAgIDEgICAxNTY0LjMgMTU4Ni4zXG5cblN0ZXA6ICBBSUM9MTM0OC42OFxuLm91dGNvbWUgfiBkMSArIGQyICsgZDMgKyBkNSArIGVkYWQgKyBlZHVjSGlnaFNjaG9vbCArIGBlbXBsZW9Ob3QgV29ya2luZ2AgKyBcbiAgICBnZW5lcm9NYWxlICsgZXN0YWRvX21hcml0YWxNYXJyaWVkICsgZmFjaWxpZGFkX2NlbHVsYXJFYXN5XG5cbiAgICAgICAgICAgICAgICAgICAgICAgIERmIERldmlhbmNlICAgIEFJQ1xuLSBlZHVjSGlnaFNjaG9vbCAgICAgICAgIDEgICAxMzI3LjIgMTM0Ny4yXG4tIGdlbmVyb01hbGUgICAgICAgICAgICAgMSAgIDEzMjcuMyAxMzQ3LjNcbi0gZDIgICAgICAgICAgICAgICAgICAgICAxICAgMTMyNy40IDEzNDcuNFxuPG5vbmU+ICAgICAgICAgICAgICAgICAgICAgICAxMzI2LjcgMTM0OC43XG4tIGQ1ICAgICAgICAgICAgICAgICAgICAgMSAgIDEzMjguOVxuIn0= -->

```
Start:  AIC=1352.52
.outcome ~ d1 + d2 + d3 + d4 + d5 + edad + educPostgraduate + 
    educHighSchool + `empleoNot Working` + generoMale + estado_maritalMarried + 
    facilidad_celularEasy

                        Df Deviance    AIC
- educPostgraduate       1   1326.6 1350.6
- d4                     1   1326.6 1350.6
- educHighSchool         1   1326.8 1350.8
- generoMale             1   1327.2 1351.2
- d2                     1   1327.3 1351.3
<none>                       1326.5 1352.5
- d5                     1   1328.8 1352.8
- d3                     1   1332.9 1356.9
- estado_maritalMarried  1   1333.4 1357.4
- d1                     1   1336.6 1360.6
- `empleoNot Working`    1   1344.2 1368.2
- facilidad_celularEasy  1   1427.2 1451.2
- edad                   1   1561.6 1585.6

Step:  AIC=1350.59
.outcome ~ d1 + d2 + d3 + d4 + d5 + edad + educHighSchool + `empleoNot Working` + 
    generoMale + estado_maritalMarried + facilidad_celularEasy

                        Df Deviance    AIC
- d4                     1   1326.7 1348.7
- educHighSchool         1   1327.1 1349.1
- generoMale             1   1327.3 1349.3
- d2                     1   1327.4 1349.4
<none>                       1326.6 1350.6
- d5                     1   1328.8 1350.8
- d3                     1   1333.0 1355.0
- estado_maritalMarried  1   1333.4 1355.4
- d1                     1   1336.7 1358.7
- `empleoNot Working`    1   1344.2 1366.2
- facilidad_celularEasy  1   1427.7 1449.7
- edad                   1   1564.3 1586.3

Step:  AIC=1348.68
.outcome ~ d1 + d2 + d3 + d5 + edad + educHighSchool + `empleoNot Working` + 
    generoMale + estado_maritalMarried + facilidad_celularEasy

                        Df Deviance    AIC
- educHighSchool         1   1327.2 1347.2
- generoMale             1   1327.3 1347.3
- d2                     1   1327.4 1347.4
<none>                       1326.7 1348.7
- d5                     1   1328.9
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

