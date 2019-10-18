import './main.css';
import { Elm } from './Main.elm';
// import { PortFunnel } from './PortFunnel.js';
import registerServiceWorker from './registerServiceWorker';

if (navigator && navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(geolocationCallback, geolocationCallback);
} else {
  geolocationCallback(); // fallback to init
}

function geolocationCallback(result) {
  let flags = undefined;
  if (result && !result.code) { // error
    flags = {
      longitude: result.coords.longitude,
      latitude: result.coords.latitude
    }
  } else {
    flags = null;
  }

  Elm.Main.init({
    node: document.getElementById('root'),
    flags
  });
}

// const modules = ['Geolocation'];
// PortFunnel.subscribe(app, {modules: modules});

// ignore for none-browser environment (electron)
if (window.location.protocol !== 'file:') {
  registerServiceWorker();
}
