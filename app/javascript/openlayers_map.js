import Wkt from './wicket';

document.addEventListener("DOMContentLoaded", function() {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    const wkt = document.getElementById("wkt-input").value;
    console.log("WKT string:", wkt);

    const wicket = new Wkt.Wkt();
    wicket.read(wkt);

    const format = new ol.format.WKT();
    const feature = format.readFeature(wicket.write(), {
      dataProjection: 'EPSG:4326',
      featureProjection: 'EPSG:3857'
    });

    const vectorSource = new ol.source.Vector({
      features: [feature]
    });

    const vectorLayer = new ol.layer.Vector({
      source: vectorSource,
      style: new ol.style.Style({
        fill: new ol.style.Fill({
          color: 'rgba(0, 0, 255, 0.5)'
        }),
        stroke: new ol.style.Stroke({
          color: '#0000ff',
          width: 2
        })
      })
    });

    const map = new ol.Map({
      target: 'map',
      layers: [
        new ol.layer.Tile({
          source: new ol.source.OSM()
        }),
        vectorLayer
      ],
      view: new ol.View({
        center: ol.proj.fromLonLat([0, 0]),
        zoom: 2
      })
    });

    map.getView().fit(vectorSource.getExtent(), { padding: [20, 20, 20, 20] });
  }
});
