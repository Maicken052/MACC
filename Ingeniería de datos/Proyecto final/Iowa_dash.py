# Librerías a instalar
from dash import Dash, html, dcc
import plotly.express as px
import psycopg2
import dash_bootstrap_components as dbc
from dash_bootstrap_templates import load_figure_template

try:
    # Conexión con la base de datos
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    app = Dash(__name__, external_stylesheets=[dbc.themes.MORPH])  # Creación de la aplicación
    load_figure_template('MORPH')  # Estilo de las gráficas
    cursor = connection.cursor()
    
    # Estilo de la página
    styles = {
        'main container': {  # Estilo del contenedor principal
            'position':'flex',
            'top':'0',
            'left':'0',
            'width': '100%',
        },

        'main column': {  # Estilo de la columna principal
            'border-radius': '20px',
            'margin-top': '1%', 
            'margin-bottom': '1%',
            'margin-left': '15%', 
            'margin-right': '15%',
            'background-color': '#E8F1F7',
            'box-shadow': '0 1px 6px rgba(0, 0, 0, 0.12), 0 1px 4px rgba(0, 0, 0, 0.24)'
        },
        
        'header': {  # Estilo del titulo
            'textAlign': 'center',
            'font-size': '40px',
            'font-weight': 'bold',
            'letter-spacing': '2px',
            'margin-top': '0',
            'border-bottom': '4px solid #C8DFEA'
        },
        
        'subtitle': {  # Estilo del subtitulo
            'font-size': '25px',
            'font-weight': 'bold',
            'margin': '20px'
        },

        'content': {  # Estilo del texto
            'font-size': '18px',
            'line-height': '1.6',
            'padding-left': '25px',
            'padding-right': '25px'
        },
        
        'indentation': {
            'margin-left': '15px',
            'margin-bottom': '0'
        },

        'graph': {  # Estilo de las gráficas
            'box-shadow': '0 2px 5px rgba(0, 0, 0, 0.1)',
            'height': '750px'
        },
        
        'graph container': {  # Estilo del contenedor de las gráficas
            'margin': '0 auto',
            'max-width': '90%',
            'justify-content': 'center', 
            'align-items': 'center'
        }
    }
    
# Todas las Consultas
    # Consulta ventas por categoria
    cursor.execute('''select c.name as category, count(s.bottle_retail) as sales_number 
                   from sells as s left outer join product as p 
                   on s.ID_product = p.ID
                   left outer join category as c 
                   on p.ID_category = c.ID
                   group by c.name''')
    rows = cursor.fetchall()

    fig11 = px.bar(rows, x=0, y=1 , labels={'0': 'Categoría de licor', '1': 'Ventas(en unidades)'})

    fig12 = px.funnel(rows, x=0, y=1, labels={'0': 'Categoría de licor', '1': 'Ventas(en unidades)'})

    fig13 = px.scatter(rows, x=0, y=1, labels={'0': 'Categoría de licor', '1': 'Ventas(en unidades)'})
    fig13.update_traces(marker_size=10)
    
    # Consulta ingresos anuales
    cursor.execute('''select cast(extract(year from s.date) as varchar) as Year, sum(s.sale) as Incomes
                   from sells as s
                   group by Year;''')
    rows2 = cursor.fetchall()

    fig21 = px.bar(rows2, x=0, y=1, labels={'0': 'Año', '1': 'Ingresos'})

    fig22 = px.pie(rows2, values=1, names=0,)

    fig23 = px.line(rows2, x=0, y=1, markers=True, labels={'0': 'Año', '1': 'Ingresos'})
    fig23.update_traces(line=dict(dash="dot", width=4, color="blue"),
                        marker=dict(color="lightblue", size=20, opacity=1))

    fig24 = px.funnel(rows2, x=0, y=1, labels={'0': 'Año', '1': 'Ingresos'})

    # Consultas ganacias por condado
    cursor.execute('''select co.name, sum((se.bottles_sold*(se.bottle_retail - se.bottle_cost))) as Earnings, to_char(se.date, 'Month') as month, extract(month from se.date) as month_number
                  from sells as se left outer join store as st on se.ID_store = st.ID
                  left outer join city as ci on st.name_city = ci.name
                  left outer join county as co on ci.ID_county = co.ID
                  group by month, co.name, month_number
                  order by month_number asc;''')
    rows3 = cursor.fetchall()

    fig31 = px.bar(rows3, x=1, y=0, color=2, orientation='h', labels={'0': 'Condado', '1': 'Ganancias', '2': 'Meses'}, color_discrete_sequence= px.colors.sequential.Magma_r)

    fig32 = px.scatter(rows3, x=0, y=1, color=2, labels={'0': 'Condado', '1': 'Ganancias', '2': 'Meses'}, color_discrete_sequence= px.colors.sequential.Cividis_r)
    fig32.update_traces(marker_size=10)

    fig33 = px.density_heatmap(rows3, x=0, y=1, nbinsx=100, nbinsy=100, labels={'0': 'Condado', '1': 'Ganancias', 'count': 'Meses'}, color_continuous_scale="Viridis")
                      
    fig34 = px.bar_polar(rows3, r=1, theta=0, color=2, color_discrete_sequence= px.colors.sequential.Plasma_r)

    # Consulta ventas mensuales
    cursor.execute('''select extract(month from s.date) as month_number, to_char(s.date, 'Month') as month, count(s.    bottle_retail) as sales_number 
                   from sells as s
                   group by month, month_number
                   order by month_number asc;''')
    rows4 = cursor.fetchall()
    
    fig41 = px.bar(rows4, x=1, y=2, labels={'0': 'Mes', '1': 'Ventas(en unidades)'})

    fig42 = px.pie(rows4, values=2, names=1)

    fig43 = px.line(rows4, x=1, y=2, markers=True, labels={'0': 'Mes', '1': 'Ventas(en unidades)'})
    fig43.update_traces(line=dict(dash="dot", width=4, color="blue"),
                        marker=dict(color="lightblue", size=20, opacity=1))

    fig44 = px.funnel(rows4, x=0, y=2, labels={'0': 'Mes', '1': 'Ventas(en unidades)'})

    # Consulta costo por categoria
    cursor.execute('''select c.name, sum(s.bottle_cost) as total_bottle_cost 
                   from category as c left outer join product as p 
                   on c.ID = p.ID_category
                   left outer join sells as s 
                   on p.ID = s.ID_product
                   group by c.name;''')
    rows5 = cursor.fetchall()

    fig51 = px.bar(rows5, x=0, y=1, labels={'0': 'Categoría', '1': 'Costo'})

    fig52 = px.scatter(rows5, x=0, y=1, labels={'0': 'Categoría', '1': 'Costo'})
    fig52.update_traces(marker_size=10)
    
    fig53 = px.funnel(rows5, x=0, y=1, labels={'0': 'Categoría', '1': 'Costo'})

    # Consulta ingresos por categoria de vodka
    cursor.execute('''select c.name, sum(s.sale) as Earnings, cast(extract(year from s.date) as varchar) as Year 
                   from category as c left outer join product as p on c.ID = p.ID_category
                   left outer join sells as s on p.ID = s.ID_product
                   where c.name like('%VODKA%') 
                   group by c.name, Year
                   order by Year asc;;''')
    rows6 = cursor.fetchall()

    fig61 = px.bar(rows6, x=1, y=0, color=2, orientation='h', labels={'0': 'Vodka', '1': 'Ingresos'})

    fig62 = px.scatter_3d(rows6, x=0, y=1, z=2, labels={'0': 'Vodka', '1': 'Ingresos', '2': 'año'})

    fig63 = px.scatter(rows6, x=0, y=1, color=2, labels={'0': 'Vodka', '1': 'Ingresos'})
    fig63.update_traces(marker_size=10)

    fig64 = px.density_heatmap(rows6, x=0, y=1, nbinsx=150, nbinsy=50, color_continuous_scale="Viridis")
   
    fig65 = px.bar_polar(rows6, r=1, theta=0, color=2, color_discrete_sequence= px.colors.sequential.Plasma_r)

    # Layout de la pagina web
    app.layout = dbc.Container(
        style= styles['main container'],  #Div para aplicar el estilo a toda la página
        children=html.Div(
            children=[ #Div con toda la información de la columna principal
                
                #Titulo de la página
                html.H1(
                    children='Venta de licor en Iowa: Análisis de escenarios', 
                    style=styles['header'],
                ),
                
                html.Br(),
                
                #Introducción
                html.P(
                    children=['''El presente trabajo está construido sobre una base de datos que recopila información sobre 
                    las compras de licor en Iowa, Estados Unidos. Los datos fueron recopilados el 23 de abril de 2023 
                    y provienen del departamento de comercio de Iowa, lo que asegura su reciente y confiable naturaleza.
                    Nuestro objetivo es realizar un análisis estadistico de los datos para obtener la mayor cantidad de 
                    información posible sobre el comportamiento que siguen las compras de licor en este estado. La razones
                    por las cuales es importante hacer esta investigación son:''',
                    html.Br(),
                    html.Strong('Conocer las tendencias del mercado: '),
                    '''revelar patrones y tendencias en las compras de licor, como los productos más populares, 
                    las marcas preferidas, las fluctuaciones estacionales en la demanda, entre otros. 
                    Estos conocimientos pueden ayudar a los comerciantes y productores a tomar decisiones informadas 
                    sobre su oferta y estrategias de marketing.''',
                    html.Br(),
                    html.Br(),
                    html.Strong('Previsualizar la demanda: '),
                    '''identificar patrones de compra y estimar la demanda futura de licor en la ciudad. 
                    Esto es útil para asegurar un suministro adecuado y evitar problemas de escasez o exceso de 
                    inventario.''',
                    html.Br(),
                    html.Br(),
                    html.Strong('Conocer la segmentación de mercado: '),
                    '''identificar segmentos específicos dentro del mercado de licor. Por ejemplo, se pueden identificar
                    grupos demográficos o ubicaciones geográficas con patrones de consumo distintos. Esta información 
                    permite adaptar estrategias de comercialización y oferta de productos según las preferencias y 
                    necesidades de cada segmento.''',
                    html.Br(),
                    html.Br(),
                    html.Strong('Realizar estudios de precios y rentabilidad: '),
                    '''proporcionar información sobre los precios promedio de venta, los márgenes de beneficio y la 
                    rentabilidad de diferentes categorías de licor. Esto ayuda a las empresas a establecer estrategias 
                    de precios y a comprender la viabilidad económica de sus productos.''',
                    html.Br(),
                    html.Br(),
                    html.Strong('Realizar investigación de mercado: '),
                    '''realizar investigaciones de mercado más amplias. Por ejemplo, se pueden combinar los datos de 
                    consumo con datos demográficos y de comportamiento del consumidor para obtener una comprensión más 
                    completa de los factores que influyen en las preferencias y elecciones de compra de los consumidores.''',
                    html.Br(),
                    html.Br(),
                    '''A continuación realizaremos un analisis a profundidad de cada uno de los escenarios elegidos:'''
                    ],
                    style=styles['content']
                ),

                #1. Sección de ventas por categoría de licor
                html.Div(
                    children=[
                        html.H2(
                            children='1. Ventas por categoría de licor',
                            style=styles['subtitle'],
                        ),

                        html.Div(
                            children=html.P(
                                children='''Para observar qué tipo de licor es más consumido en el estado de Iowa, 
                                se consulta el número de ventas realizado por cada categoría de licor. A continuación 
                                se presentan las gráficas realizadas que dejan ver de manera clara la consulta que 
                                queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            children=dcc.Graph(
                                id='Barras-Cat',
                                figure=fig11,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Embudo-Cat',
                                figure=fig12,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Dispersion-Cat',
                                figure=fig13,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, se puede evidenciar que la categoría que más tiene registrada ventas es 
                                “VODKA 80 PROOF”, con un total de 131.167 ventas, seguido por “CANADIAN WHISKIES” con 98.621 ventas. Estas 
                                dos categorías tienen ventas bastante mayores en comparación al resto de categorías, esto ya que la tercera 
                                más vendida, es decir “STRAIGHT BOURBON WHISKIES” cuenta con 57.974 ventas, siendo un numero qué, además de 
                                alejarse bastante de las 2 primeras categorías, es un valor similar al que tienen otras categorías, siendo 
                                posible evidenciar que no se cuentan con valores muy destacables en el resto de los datos, teniendo algunos 
                                un número de ventas que es casi imperceptible en la visualización de los datos.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''se puede evidenciar que son bastantes las categorías que no gozan de muchas ventas, lo cual genera la sospecha 
                                de estas corresponden a tipos de licor muy específicos, y que, debido a su exclusividad o desconocimiento popular, 
                                no suelen tener mucha demanda en el mercado. Por otro lado, los más demandados se sospecha son tipos de licor más 
                                comunes y populares entre las personas, por tanto, son los que tienen más demanda en el mercado, ya que estas 
                                categorías tienen más productos en su haber. De esto se concluye que, si se quiere que un licor sea popular, debe 
                                ser de una categoría bien conocida entre los consumidores.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, la de barras muestra un mayor número de datos, permitiendo ver de forma clara la 
                                frecuencia de cada una de las categorías; sin embargo, al ser bastantes datos, los mismos pueden verse algo 
                                apretados entre sí. La de embudo es similar a la de barras, permitiendo visualizar varios datos, con el agregado 
                                de que se puede apreciar mejor la comparativa entre categorías, pero de igual manera la gráfica se puede ver algo 
                                apretada dado el gran número de datos. Por último, la de dispersión presenta un mayor orden entre los datos, no 
                                apreciándose tan juntos entre sí; sin embargo, pueden presentarse algunas dificultades al ver que valor tiene cada 
                                punto, esto dado que el punto no es tan exacto en dar valores como los anteriores diagramas.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )
                    ]
                ),

                #2. Sección de ingresos anuales por venta de licor
                html.Div(
                    children=[
                        html.H2(
                            children='2. Ingresos anuales por venta de licor',
                            style=styles['subtitle']
                        ),
                        
                        html.Div(
                            children=html.P(
                                children='''Para analizar el total de ingresos en el estado de Iowa por ventas de licor
                                cada año, se consultan los ingresos anuales por ventas de licor. A continuación 
                                se presentan las gráficas realizadas que dejan ver de manera clara la consulta que 
                                queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Br(),
                        
                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            dcc.Graph(
                                id='Barras-An',
                                figure=fig21,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Pie-An',
                                figure=fig22,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Linea-An',
                                figure=fig23,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Embudo-An',
                                figure=fig24,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, se puede ver que el año que más tuvo ingresos mediante las ventas de licor fue 
                                2014, seguido de 2013, luego 2012 y por último 2015. Sin embargo, se puede apreciar que la diferencia de ingresos 
                                entre años no es tan grande, viéndose en diagramas como el de pie que tienen cantidades de ventas bastante similares 
                                entre sí. Por ello, se puede concluir que la venta de licor se mantiene constante a través de los años, teniendo 
                                unos ingresos entre 32M y 34M, que son los valores que se evidencian en estos años.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''se puede apreciar que en todos los años se consiguen ingresos bastante similares, siendo en promedio 33M de dólares 
                                por año gracias a la venta de licor. El hecho de que no varie mucho esta cantidad con el paso de los años y de que 
                                genere bastantes ganancias, es un indicativo de que el mercado del licor es uno bastante rentable en Iowa, ya que 
                                genera bastantes ingresos y estos se mantienen estables con cada año que pasa, generando más seguridad para invertir 
                                en este mercado.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, la de barras permite ver los datos de manera clara al ser pocos datos; sin embargo, dada 
                                la poca diferencia entre los datos puede ser algo difícil la comparativa. Algo similar ocurre con el de embudo, ya 
                                que permite ver los datos de manera muy clara, pero pueden llegar a verse de una altura bastante similar, per la 
                                profundidad permite un poco más de comparación respecto al de barras. La de pie permite ver el porcentaje que 
                                abarcan los datos de manera clara; sin embargo, dada la similar entre la cantidad de cada dato, se podría pensar 
                                que todos los años cuentan con el mismo porcentaje, apreciándose poca diferencia entre los mismos. Por último, la 
                                de línea ofrece una visión mucho más clara de las diferencias entre años, visualizando los incrementos entre uno y 
                                otro gracias a las conexiones entre puntos, siendo la mejor gráfica para ver comparativas entre los valores anuales.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )
                    ]
                ),

                #3. Sección de ganancias mensuales por venta de licor por condado
                html.Div(
                    children=[
                        html.H2(
                            children='3. Ganancias mensuales por venta de licor por condado',
                            style=styles['subtitle']
                        ),
                        
                        html.Div(
                            children=html.P(
                                children='''Para analizar las ganancias mensuales por ventas de licor de las tiendas 
                                por condado, se consultan las ganancias por condado en cada mes del año. A continuación
                                se presentan las gráficas realizadas que dejan ver de manera clara la consulta que 
                                queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Br(),
                        
                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            dcc.Graph(
                                id='Barras-Con',
                                figure=fig31,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Dispersion-Con',
                                figure=fig32,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Calor-Con',
                                figure=fig33,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Polar-Con',
                                figure=fig34,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, se puede ver que, por una diferencia bastante significativa, el condado “POLK” 
                                es el que más ganancias ve reflejadas por venta de licor. Respecto al segundo con más ganancias, es decir “LINN”, 
                                la diferencia con “POLK” es de un poco más del doble, concluyendo que “POLK” es el condado donde más ventas de 
                                licor se hacen y muy probablemente donde más diste el precio de venta del costo original del licor, de forma que 
                                puede generar más utilidades. En la mayoría de otros condados, se ve que las ganancias no son tan destacables, 
                                sospechándose que no se logra ganar mucho de la venta de licor en bastantes condados. Añadido a esto, se puede 
                                evidenciar que la segmentación por meses es bastante uniforme, es decir que los valores se parecen bastante entre 
                                sí, denotando estabilidad a lo largo de los meses.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''se puede ver que son muchos los condados que no tienen muchas ganancias por ventas de alcohol, lo cual puede 
                                deberse a que son condados más pequeños, y que por tanto no tienen una población tan grande interesada en la 
                                compra de alcohol ni muchas tiendas disponibles en las que comprarlo. Por ello, se concluye que es más rentable 
                                vender alcohol en condados grandes y concurridos, para que así se puedan realizar más cantidad de ventas, y de 
                                esta forma poder generar más ganancias. Además, podemos ver que no hay mucha variabilidad en las ganancias respecto 
                                a la segmentación por meses, por lo cual se puede tener seguridad en que las ganancias no varían mucho según el 
                                mes, sino que más bien dependen de la parte de Iowa en la que se comercialice.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, la de barras presenta un resumen completo de todos los datos y los valores que los 
                                mismos pueden tomar, mostrando la segmentación por meses de cada uno correctamente; sin embargo, pueden verse algo 
                                pegados entre sí, viéndose algo desordenados. En el de dispersión podemos ver mucho más claramente la variabilidad 
                                de los datos respecto al mes, y al no estar los puntos tan pegados se ve más ordenado, sin embargo, es más inexacto 
                                que el de barras en cuanto a los valores que toma cada punto. El de calor presenta una visualización interesante, 
                                ya que permite ver que tanta variabilidad presenta cada condado con los meses, esto según la intensidad de los 
                                colores, viendo que la mayoría tienen colores intensos, denotando estabilidad en meses. Por último, el diagrama 
                                polar presenta los datos de mayor a menor, siendo posible comparar de manera más efectiva la magnitud de los datos 
                                del análisis.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )
                    ]
                ),
                
                #4. Sección de ventas mensuales de licor
                html.Div(
                    children=[
                        html.H2(
                            children='4. Ventas mensuales de licor',
                            style=styles['subtitle']
                        ),
                        
                        html.Div(
                            children=html.P(
                                children='''Con el objetivo de identificar el mes en el que más se compra licor, se 
                                consulta el mes con mayor volumen de ventas A continucación se presentan las gráficas 
                                realizadas que dejan ver de manera clara la consulta que queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            dcc.Graph(
                                id='Barras-Men',
                                figure=fig41,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Pie-Men',
                                figure=fig42,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Linea-Men',
                                figure=fig43,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Embudo-Men',
                                figure=fig44,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, puede apreciarse que los meses en los que más hay ventas de licor es en mayo 
                                y en octubre, teniendo los dos casi el mismo número de ventas. Por otro lado, se aprecia que enero y febrero son 
                                los meses en los que hay menos ventas de licor. Hablando generalmente, si bien se puede ver una diferencia entre 
                                los meses según su número de ventas, la misma no es muy amplia, lo cual indica que los incrementos en ventas de 
                                alcohol, si bien se pueden apreciar, no son demasiado amplios, teniendo cierta consistencia en la cantidad de 
                                ventas entre meses.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''si bien la diferencia de meses no es muy grande, tampoco es despreciable, por lo cual, si se desea maximizar 
                                los ingresos y ventas por alcohol estando en Iowa, es mucho más recomendable vender licor en mayo y octubre, ya 
                                que son estos meses en donde los datos apuntan a que se produzcan más ventas de alcohol. Así, se puede ver que la 
                                época del año en donde se venda alcohol influye en las ganancias obtenidas, ya que hay ciertos meses con más 
                                movimiento que otros.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, la de barras y la de embudo permiten una buena visualización de los datos, con buen 
                                tamaño, anchura y diferencia visible entre los datos, siendo la de embudo un poco más efectiva en cuanto a las 
                                comparativas al presentar profundidad. Por otro lado, el diagrama de línea ofrece una mayor diferenciación entre 
                                las ventas de los meses, siendo posible observar las subidas o bajadas entre uno y otro. Por último, el de pie 
                                presenta los porcentajes que abarca cada mes, pero es en el que menos diferencia puede evidenciarse entre los 
                                datos, viéndose todos muy similares entre sí.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )
                    ]
                ),
 
                #5. Sección de costo por categoría de licor
                html.Div(
                    children=[
                        html.H2(
                            children='5. Costo por categoría de licor',
                            style=styles['subtitle']
                        ),
                        
                        html.Div(
                            children=html.P(
                                children='''Con el fin de comparar los precios de cada categoría en las tiendas, se 
                                hace una consulta relacionada a la diferencia de los costos de algunas categorías. 
                                A continucación se presentan las gráficas realizadas que dejan ver de manera clara la 
                                consulta que queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),
                        
                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            dcc.Graph(
                                id='Barras-Cos',
                                figure=fig51,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Dispersión-Cos',
                                figure=fig52,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Embudo-Cos',
                                figure=fig53,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, podemos ver que la categoría que más representa costos para las tiendas 
                                es “CANADIAN WHISKIES”, seguida de “VODKA 80 PROOF”, siendo las demás bastante similares en frecuencia, 
                                contando mayormente con valores considerables, pero no tan altos como las dos primeras. Se puede apreciar 
                                que este diagrama se parece bastante al diagrama de ventas por categoría, apreciándose que “CANADIAN WHISKIES” 
                                es mayor en costos, pero “VODKA 80 PROOF” es mayor en ventas, concluyéndose con estos dos casos que el costo y 
                                las ventas tienen una relación, ya que puede que se venda menos, pero puede ser mayor en costo.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''comparando con el análisis de las ventas por categoría, se puede evidenciar que algunas que tienen menos 
                                valor en ventas, pero más valor en costos, por lo cual se puede sospechar que aquellos datos que tienen un valor 
                                mayor en costos que en ventas, se venden menos debido a que tienen un costo más elevado, explicando la relación
                                entre ventas, costos y popularidad de un producto, viendo que, si cuesta menos, puede venderse más.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, barras y embudo muestran los datos en su totalidad, viéndose un diagrama amplio y 
                                completo. Sin embargo, pueden verse algo pegadas las barras entre sí, lo cual genera cierta sensación de desorden 
                                y algunas dificultades menores en su lectura. En cuanto al de dispersión, se ve más ordenados que los anteriores, 
                                ya que los puntos tienen más distancia entre si de lo que tienen las barras, pero puede generar problemas en 
                                cuanto a la estimación de su valor, ya que los puntos son un poco más inexactos en la representación de valores 
                                que los anteriores.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )      
                    ]
                ),

                #6. Sección de ingresos anuales por categoría de vodka
                html.Div(
                    children=[
                        html.H2(
                            children='6. Ingresos anuales por categoría de vodka',
                            style=styles['subtitle']
                        ),
                        
                        html.Div(
                            children=html.P(
                                children='''Para observar qué tipo de licor es más consumido en el estado de Iowa por cada año, 
                                se consulta el número de ventas realizado por cada categoría de licor en cada año registrado. A continuación 
                                se presentan las gráficas realizadas que dejan ver de manera clara la consulta que queremos hacer.''',
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=html.Strong('Gráficas: '),
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        ),

                        html.Div(
                            dcc.Graph(
                                id='Barras-Vod',
                                figure=fig61,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            html.Div(
                                dcc.Graph(
                                    id='Scatter-Vod',
                                    figure=fig62,
                                    style=styles['graph']
                                )
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Dispersión-Vod',
                                figure=fig63,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Calor-Vod',
                                figure=fig64,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),
                        
                        html.Br(),
                        
                        html.Div(
                            dcc.Graph(
                                id='Polar-Vod',
                                figure=fig65,
                                style=styles['graph']
                            ),
                            style=styles['graph container']
                        ),

                        html.Br(),

                        html.Div(
                            children=html.P(
                                children=[
                                html.Strong('Discusiones: '),
                                html.Br(),
                                html.Strong('Samuel: '),
                                '''de acuerdo con los diagramas, se puede apreciar que “VODKA 80 PROOF” es el tipo de vodka que genera más 
                                ingresos, seguido de “IMPORTED VODKA” y “VODKA FLAVORED”; sin embargo, estos están considerablemente alejados 
                                de los ingresos del primero. De igual manera, y viendo la segmentación por años, vemos nuevamente que los ingresos 
                                de cada categoría se mantienen estables por cada año, sin presentar mayores cambios. De acuerdo con datos de 
                                organizaciones de comercio en Iowa como lo es “Iowa Alcoholic Beverages Division”, el tipo de licor más consumido 
                                en Iowa es el vodka, lo cual se puede apreciar en estos datos, dados los altos valores que toman la mayoría de sus 
                                tipos.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Lukas: '),
                                '''viendo los datos, y teniendo en cuenta el supuesto anterior de que el vodka es el tipo de licor más consumido 
                                en Iowa, vemos que la mayoría de los tipos generan muchos ingresos. Esto sumado a que la categoría más consumida 
                                en general es “VODKA 80 PROOF”, da la sospecha de que el vodka, efectivamente, es el tipo de licor más popular en 
                                Iowa, y es mucho más rentable vender vodka en Iowa. Por último, podemos ver que el año no influye mucho en cuanto 
                                a variabilidad de ingresos, viendo seguridad de que todo el tiempo, los grandes ingresos del vodka se mantienen
                                estables.''',
                                html.Br(),
                                html.Br(),
                                html.Strong('Daniel: '),
                                '''respecto a las gráficas, la de barras muestra una visualización bastante completa de los datos, teniendo barras 
                                grandes y un buen orden en los mismos, viéndose muy clara la segmentación por años. La de dispersión 2D es bastante 
                                similar, presentando un mayor orden en los datos, pero siendo algo más imprecisa en cuanto a los datos exactos de 
                                cada una. Tambien se realizó uno de dispersión 3D, que permite ver con mas claridad el estado de cada categoría
                                respecto al año, siendo un diagrama muy interactivo y completo. El diagrama de calor permite ver con claridad cuales datos pueden variar más o menos según los años, 
                                viéndose que algunas varían más o menos según el año, esto de acuerdo a la intensidad del color que tengan. 
                                Finalmente, el diagrama polar permite ver de manera ordenada los datos de mayor a menor, ofreciendo otra forma de ordenar los datos y 
                                compararlos de mejor manera.'''
                                ],
                                style=styles['content']
                            ),
                            style=styles['indentation']
                        )
                    ]
                ),

                html.H2(
                    children='Conclusiones',
                    style=styles['subtitle'],
                ),
                
                html.Div(
                    children=html.P(
                        children=[
                        html.Strong('Samuel: '),
                        '''este proyecto fue producto de un trabajo bastante extenso, esto debido a todo lo que implicó la consecución, 
                        visualización y análisis final de los datos. Comenzando por la selección de la base de datos, que requirió de 
                        una búsqueda extensa, la cual tenía como fin conseguir una base de datos que tuviese varias columnas, llaves 
                        primarias, valores multivariados y algunos valores derivados, siendo estas características que cumple nuestra
                        base de datos. Una base de datos sobre venta de bebidas alcohólicas en una locación específica podría sonar 
                        en primera instancia como un proyecto simple y que no requiere de mucho análisis. Pero si se ahonda más en 
                        el mismo, se puede ver todo lo que implica la venta de una botella de alcohol, yendo desde los precios de 
                        compraventa, el lugar específico donde este se vende, el tipo de alcohol, el proveedor del alcohol y el 
                        nombre de la bebida, entre otros datos que hacen de este un proyecto complejo, y que tiene muchos datos 
                        posibles que analizar. Añadido a esto, la complejidad en las condiciones que debe tener una base de datos 
                        nos permitió desarrollar una capacidad mayor de selección en cuanto a bases datos, aprendiendo a identificar 
                        cual es más o menos útil para crear un análisis mucho más completo y elaborado.''',
                        html.Br(),
                        html.Br(),
                        html.Strong('Lukas: '),
                        '''en cuanto al diseño de la base, se tuvieron que hacer un numero grande de filtros, esto debido a que había datos 
                        que no estaban completos, que no eran del todo comprensibles o que simplemente no eran pertinentes para el estudio.
                        Luego de esto se aplicó normalización a la tabla, sacando provecho de los diversos atributos de la misma, sacando 
                        una cantidad de entidades amplia, y que permitía un proyecto ordenado y bastante compuesto. La subida de datos en 
                        PgAdmin4 se realizó mediante archivos csv, usando la función “COPY” para poder traspasar los datos a las tablas 
                        que con anterioridad se crearon en base al Excel normalizado, siendo posible subir más de 1 millón de registros 
                        en poco tiempo y sin mayores complicaciones. Respecto a las conexiones con Dash mediante Python, esta fue la parte 
                        más compleja de hacer, ya que para ello se tuvo que manejar la librería “psycopg2”, lo cual permitió tener una 
                        mayor comprensión y aprendizaje sobre conexiones entre plataformas, en este caso PgAdmin4 y Python, siendo un 
                        conocimiento bastante útil para proyectos a futuro.''',
                        html.Br(),
                        html.Br(),
                        html.Strong('Daniel: '),
                        '''en cuanto al manejo de Dash, me llevo a adquirir bastantes conocimientos nuevos en el mundo de la programación, 
                        ya que en el mismo también se usa como agregado la librería “plotly.express”, la cual se utiliza para gráficas, 
                        teniendo que aprender como graficar datos de una base de datos. De igual manera, también tuvimos que aprender lo 
                        básico de HTML, plataforma muy utilizada para diseño web, por lo cual estos conocimientos serán bastante aplicables
                        para la carrera en un futuro. Finalmente, la creación de escenarios de análisis y la discusión de las gráficas de 
                        los mismos nos permitió pensar en la situación problema desde otras perspectivas, aumentando la creatividad y los 
                        diferentes enfoques que se le pueden dar a un estudio o análisis. Respecto a las gráficas es bastante similar, 
                        ya que la realización de este proyecto nos permitió sacar conclusiones y deducciones sobre análisis que, vistos de 
                        otra manera, no habría sido posible analizar sin ayuda visual por la cantidad masiva de datos. En general, fue un 
                        proyecto que implicó la adquisición de bastantes conocimientos, métodos, formas de pensar y analizar problemas, ya 
                        que, al ser nuestro primer acercamiento a la aplicación de bases de datos en contextos reales, permitió conocer 
                        todo el alcance que pueden llegar a tener las mismas si se hace su análisis y estudio de la manera correcta. Este 
                        primer acercamiento sirve para darnos una idea de lo que podemos llegar a crear con bases de datos, dándonos las 
                        herramientas necesarias para en un futuro poder hacer proyectos más complejos y masivos, y así poder hacer uso de 
                        estos conocimientos en un mundo laboral y corporativo. ''',
                        html.Br(),
                        html.Br(),
                        html.Sub(
                            children='''Trabajo realizado por Daniel Fonseca, Samuel de Dios y Lukas Morera.'''
                        ),
                        html.Br(),
                        html.Br()
                        ],
                        style=styles['content']
                    ),
                    style=styles['indentation']
                )
            ],
            style=styles['main column'],
        ),
        className='dbc'
    )
    
    if __name__ == '__main__':
        app.run_server(debug=False)

# Comandos de finalización        
except Exception as ex:
    print(ex)
    
finally:
    connection.close()
