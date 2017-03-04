Aplicación simplificada de Airbnb

Cuenta con un login mediante FB, y un tabbar con las siguientes pestañas:
-Perfil
-Listado de alojamientos de tu ciudad
-Mapa con alojamientos de tu ciudad

Hace uso de los siguientes endpoints:

Listar alojamientos
https://api.airbnb.com/v2/search_results?client_id=3092nxybyb0otqw18e8nh5nty

Detalle de un alojamiento
https://api.airbnb.com/v2/listings/5116458?client_id=3092nxybyb0otqw18e8nh5nty&_format=v1_legacy_for_p3

API detallada
http://airbnbapi.org/#listing-search

Librerias utilizadas: SVProgressHUD,AFNetworking,SDWebImage,FacebookSDK

Descargue el proyecto y ejecute pod install para instalar las librerias.
PD: el framework de fb no se encuentra en el repositorio, debe descargar FBSDKCoreKit y FBSDKLoginKit, luego agreguelos a la carpeta raiz del proyecto
