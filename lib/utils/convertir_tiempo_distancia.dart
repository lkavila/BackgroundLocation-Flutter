class ConvertirTD{

  static String convertDistancia(double distancia){
    if (distancia<1000){
      return distancia.round().toString()+" metros";
    }
    distancia = distancia/1000; //distancia se recibe en metros y se pasa a kilometros 
    if(distancia>=100000){
      return distancia.round().toString()+" kilometros";
    }else{
      int kil = distancia.floor();
      double metros = (distancia - kil)*1000;
      return (kil.toString()+"  kilometros y "+metros.round().toString()+" mts");
    }
  } 

  static String convertirTiempo(double duracion){
    //duracion esta en segundos
    if(duracion<=60){
      return duracion.toString()+" segundos";
    }else{
      duracion = duracion/60;
      if (duracion<60){
        double min = duracion.floorToDouble();
        double seg = (duracion - min)*60;
        return (min.round().toString()+" minutos con "+ seg.round().toString())+ " segundos";
      }else{
        duracion = duracion/60;
        double hours = duracion.floorToDouble();
        double min = (duracion - hours)*60;
        if (hours==1){
          return (hours.round().toString()+" hora con "+min.round().toString()+" min");
        }else{
          return (hours.round().toString()+" horas con "+min.round().toString()+" min");
        }
      }

    }
  }
}