// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  // `loadDynamicModule` is a JS function that takes two string names matching,
  //   in order, a wasm file produced by the dart2wasm compiler during dynamic
  //   module compilation and a corresponding js file produced by the same
  //   compilation. It should return a JS Array containing 2 elements. The first
  //   should be the bytes for the wasm module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The second
  //   should be the result of using the JS 'import' API on the js file path.
  async instantiate(additionalImports, {loadDeferredWasm, loadDynamicModule} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + value;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {
            _3: (o, t) => typeof o === t,
      _4: (o, c) => o instanceof c,
      _7: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._7(f,arguments.length,x0) }),
      _8: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._8(f,arguments.length,x0) }),
      _36: () => new Array(),
      _37: x0 => new Array(x0),
      _39: x0 => x0.length,
      _41: (x0,x1) => x0[x1],
      _42: (x0,x1,x2) => { x0[x1] = x2 },
      _43: x0 => new Promise(x0),
      _45: (x0,x1,x2) => new DataView(x0,x1,x2),
      _47: x0 => new Int8Array(x0),
      _48: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _49: x0 => new Uint8Array(x0),
      _51: x0 => new Uint8ClampedArray(x0),
      _53: x0 => new Int16Array(x0),
      _55: x0 => new Uint16Array(x0),
      _57: x0 => new Int32Array(x0),
      _59: x0 => new Uint32Array(x0),
      _61: x0 => new Float32Array(x0),
      _63: x0 => new Float64Array(x0),
      _65: (x0,x1,x2) => x0.call(x1,x2),
      _70: (decoder, codeUnits) => decoder.decode(codeUnits),
      _71: () => new TextDecoder("utf-8", {fatal: true}),
      _72: () => new TextDecoder("utf-8", {fatal: false}),
      _73: (s) => +s,
      _74: x0 => new Uint8Array(x0),
      _75: (x0,x1,x2) => x0.set(x1,x2),
      _76: (x0,x1) => x0.transferFromImageBitmap(x1),
      _78: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._78(f,arguments.length,x0) }),
      _79: x0 => new window.FinalizationRegistry(x0),
      _80: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _81: (x0,x1) => x0.unregister(x1),
      _82: (x0,x1,x2) => x0.slice(x1,x2),
      _83: (x0,x1) => x0.decode(x1),
      _84: (x0,x1) => x0.segment(x1),
      _85: () => new TextDecoder(),
      _87: x0 => x0.click(),
      _88: x0 => x0.buffer,
      _89: x0 => x0.wasmMemory,
      _90: () => globalThis.window._flutter_skwasmInstance,
      _91: x0 => x0.rasterStartMilliseconds,
      _92: x0 => x0.rasterEndMilliseconds,
      _93: x0 => x0.imageBitmaps,
      _120: x0 => x0.remove(),
      _121: (x0,x1) => x0.append(x1),
      _122: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _125: (x0,x1) => x0.removeChild(x1),
      _202: x0 => x0.stopPropagation(),
      _203: x0 => x0.preventDefault(),
      _205: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _249: x0 => x0.select(),
      _250: (x0,x1) => x0.execCommand(x1),
      _252: x0 => x0.unlock(),
      _253: x0 => x0.getReader(),
      _254: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _255: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _256: (x0,x1) => x0.item(x1),
      _257: x0 => x0.next(),
      _258: x0 => x0.now(),
      _259: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._259(f,arguments.length,x0) }),
      _260: (x0,x1) => x0.addListener(x1),
      _261: (x0,x1) => x0.removeListener(x1),
      _262: (x0,x1) => x0.matchMedia(x1),
      _263: (x0,x1) => x0.revokeObjectURL(x1),
      _264: x0 => x0.close(),
      _265: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _266: x0 => new window.ImageDecoder(x0),
      _267: x0 => ({frameIndex: x0}),
      _268: (x0,x1) => x0.decode(x1),
      _269: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._269(f,arguments.length,x0) }),
      _270: (x0,x1) => x0.getModifierState(x1),
      _271: (x0,x1) => x0.removeProperty(x1),
      _272: (x0,x1) => x0.prepend(x1),
      _273: x0 => x0.disconnect(),
      _274: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._274(f,arguments.length,x0) }),
      _275: x0 => x0.blur(),
      _276: x0 => x0.hasFocus(),
      _277: (x0,x1) => x0.hasAttribute(x1),
      _278: (x0,x1) => x0.getModifierState(x1),
      _282: (x0,x1) => x0.appendChild(x1),
      _283: (x0,x1) => x0.createTextNode(x1),
      _284: (x0,x1) => x0.removeAttribute(x1),
      _285: x0 => x0.getBoundingClientRect(),
      _286: (x0,x1) => x0.contains(x1),
      _287: (x0,x1) => x0.observe(x1),
      _288: x0 => x0.disconnect(),
      _289: (x0,x1) => x0.closest(x1),
      _290: (x0,x1) => x0.getAttribute(x1),
      _700: () => globalThis.window.flutterConfiguration,
      _701: x0 => x0.assetBase,
      _707: x0 => x0.debugShowSemanticsNodes,
      _708: x0 => x0.hostElement,
      _709: x0 => x0.multiViewEnabled,
      _710: x0 => x0.nonce,
      _712: x0 => x0.fontFallbackBaseUrl,
      _716: x0 => x0.console,
      _717: x0 => x0.devicePixelRatio,
      _718: x0 => x0.document,
      _719: x0 => x0.history,
      _720: x0 => x0.innerHeight,
      _721: x0 => x0.innerWidth,
      _722: x0 => x0.location,
      _723: x0 => x0.navigator,
      _724: x0 => x0.visualViewport,
      _725: x0 => x0.performance,
      _727: x0 => x0.URL,
      _729: (x0,x1) => x0.getComputedStyle(x1),
      _730: x0 => x0.screen,
      _731: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._731(f,arguments.length,x0) }),
      _732: (x0,x1) => x0.requestAnimationFrame(x1),
      _737: (x0,x1) => x0.warn(x1),
      _739: (x0,x1) => x0.debug(x1),
      _740: x0 => globalThis.parseFloat(x0),
      _741: () => globalThis.window,
      _742: () => globalThis.Intl,
      _743: () => globalThis.Symbol,
      _744: (x0,x1,x2,x3,x4) => globalThis.createImageBitmap(x0,x1,x2,x3,x4),
      _746: x0 => x0.clipboard,
      _747: x0 => x0.maxTouchPoints,
      _748: x0 => x0.vendor,
      _749: x0 => x0.language,
      _750: x0 => x0.platform,
      _751: x0 => x0.userAgent,
      _752: (x0,x1) => x0.vibrate(x1),
      _753: x0 => x0.languages,
      _754: x0 => x0.documentElement,
      _755: (x0,x1) => x0.querySelector(x1),
      _758: (x0,x1) => x0.createElement(x1),
      _761: (x0,x1) => x0.createEvent(x1),
      _762: x0 => x0.activeElement,
      _765: x0 => x0.head,
      _766: x0 => x0.body,
      _768: (x0,x1) => { x0.title = x1 },
      _771: x0 => x0.visibilityState,
      _772: () => globalThis.document,
      _773: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._773(f,arguments.length,x0) }),
      _774: (x0,x1) => x0.dispatchEvent(x1),
      _782: x0 => x0.target,
      _784: x0 => x0.timeStamp,
      _785: x0 => x0.type,
      _787: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _793: x0 => x0.baseURI,
      _794: x0 => x0.firstChild,
      _798: x0 => x0.parentElement,
      _800: (x0,x1) => { x0.textContent = x1 },
      _801: x0 => x0.parentNode,
      _803: x0 => x0.isConnected,
      _807: x0 => x0.firstElementChild,
      _809: x0 => x0.nextElementSibling,
      _810: x0 => x0.clientHeight,
      _811: x0 => x0.clientWidth,
      _812: x0 => x0.offsetHeight,
      _813: x0 => x0.offsetWidth,
      _814: x0 => x0.id,
      _815: (x0,x1) => { x0.id = x1 },
      _818: (x0,x1) => { x0.spellcheck = x1 },
      _819: x0 => x0.tagName,
      _820: x0 => x0.style,
      _822: (x0,x1) => x0.querySelectorAll(x1),
      _823: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _825: (x0,x1) => { x0.tabIndex = x1 },
      _826: (x0,x1) => x0.focus(x1),
      _827: x0 => x0.scrollTop,
      _828: (x0,x1) => { x0.scrollTop = x1 },
      _829: x0 => x0.scrollLeft,
      _830: (x0,x1) => { x0.scrollLeft = x1 },
      _831: x0 => x0.classList,
      _833: (x0,x1) => { x0.className = x1 },
      _835: (x0,x1) => x0.getElementsByClassName(x1),
      _836: (x0,x1) => x0.attachShadow(x1),
      _839: x0 => x0.computedStyleMap(),
      _840: (x0,x1) => x0.get(x1),
      _846: (x0,x1) => x0.getPropertyValue(x1),
      _847: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _848: x0 => x0.offsetLeft,
      _849: x0 => x0.offsetTop,
      _850: x0 => x0.offsetParent,
      _852: (x0,x1) => { x0.name = x1 },
      _853: x0 => x0.content,
      _854: (x0,x1) => { x0.content = x1 },
      _858: (x0,x1) => { x0.src = x1 },
      _859: x0 => x0.naturalWidth,
      _860: x0 => x0.naturalHeight,
      _864: (x0,x1) => { x0.crossOrigin = x1 },
      _866: (x0,x1) => { x0.decoding = x1 },
      _867: x0 => x0.decode(),
      _872: (x0,x1) => { x0.nonce = x1 },
      _876: (x0,x1) => { x0.width = x1 },
      _879: (x0,x1) => { x0.height = x1 },
      _882: (x0,x1) => x0.getContext(x1),
      _941: (x0,x1) => x0.fetch(x1),
      _942: x0 => x0.status,
      _944: x0 => x0.body,
      _945: x0 => x0.arrayBuffer(),
      _948: x0 => x0.read(),
      _949: x0 => x0.value,
      _950: x0 => x0.done,
      _952: x0 => x0.name,
      _953: x0 => x0.x,
      _954: x0 => x0.y,
      _957: x0 => x0.top,
      _958: x0 => x0.right,
      _959: x0 => x0.bottom,
      _960: x0 => x0.left,
      _972: x0 => x0.height,
      _973: x0 => x0.width,
      _974: x0 => x0.scale,
      _975: (x0,x1) => { x0.value = x1 },
      _977: (x0,x1) => { x0.placeholder = x1 },
      _978: (x0,x1) => { x0.name = x1 },
      _980: x0 => x0.selectionDirection,
      _981: x0 => x0.selectionStart,
      _982: x0 => x0.selectionEnd,
      _985: x0 => x0.value,
      _987: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _988: x0 => x0.readText(),
      _989: (x0,x1) => x0.writeText(x1),
      _991: x0 => x0.altKey,
      _992: x0 => x0.code,
      _993: x0 => x0.ctrlKey,
      _994: x0 => x0.key,
      _995: x0 => x0.keyCode,
      _996: x0 => x0.location,
      _997: x0 => x0.metaKey,
      _998: x0 => x0.repeat,
      _999: x0 => x0.shiftKey,
      _1000: x0 => x0.isComposing,
      _1002: x0 => x0.state,
      _1003: (x0,x1) => x0.go(x1),
      _1005: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1006: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1007: x0 => x0.pathname,
      _1008: x0 => x0.search,
      _1009: x0 => x0.hash,
      _1013: x0 => x0.state,
      _1016: (x0,x1) => x0.createObjectURL(x1),
      _1018: x0 => new Blob(x0),
      _1020: x0 => new MutationObserver(x0),
      _1021: (x0,x1,x2) => x0.observe(x1,x2),
      _1022: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1022(f,arguments.length,x0,x1) }),
      _1025: x0 => x0.attributeName,
      _1026: x0 => x0.type,
      _1027: x0 => x0.matches,
      _1028: x0 => x0.matches,
      _1032: x0 => x0.relatedTarget,
      _1034: x0 => x0.clientX,
      _1035: x0 => x0.clientY,
      _1036: x0 => x0.offsetX,
      _1037: x0 => x0.offsetY,
      _1040: x0 => x0.button,
      _1041: x0 => x0.buttons,
      _1042: x0 => x0.ctrlKey,
      _1046: x0 => x0.pointerId,
      _1047: x0 => x0.pointerType,
      _1048: x0 => x0.pressure,
      _1049: x0 => x0.tiltX,
      _1050: x0 => x0.tiltY,
      _1051: x0 => x0.getCoalescedEvents(),
      _1054: x0 => x0.deltaX,
      _1055: x0 => x0.deltaY,
      _1056: x0 => x0.wheelDeltaX,
      _1057: x0 => x0.wheelDeltaY,
      _1058: x0 => x0.deltaMode,
      _1065: x0 => x0.changedTouches,
      _1068: x0 => x0.clientX,
      _1069: x0 => x0.clientY,
      _1072: x0 => x0.data,
      _1074: (x0,x1) => { x0.disabled = x1 },
      _1077: (x0,x1) => { x0.type = x1 },
      _1078: (x0,x1) => { x0.max = x1 },
      _1079: (x0,x1) => { x0.min = x1 },
      _1080: (x0,x1) => { x0.value = x1 },
      _1081: x0 => x0.value,
      _1082: (x0,x1) => { x0.disabled = x1 },
      _1083: x0 => x0.disabled,
      _1085: (x0,x1) => { x0.placeholder = x1 },
      _1087: (x0,x1) => { x0.name = x1 },
      _1089: (x0,x1) => { x0.autocomplete = x1 },
      _1090: x0 => x0.selectionDirection,
      _1091: x0 => x0.selectionStart,
      _1094: x0 => x0.selectionEnd,
      _1096: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1097: (x0,x1) => x0.add(x1),
      _1100: (x0,x1) => { x0.noValidate = x1 },
      _1101: (x0,x1) => { x0.method = x1 },
      _1102: (x0,x1) => { x0.action = x1 },
      _1128: x0 => x0.orientation,
      _1129: x0 => x0.width,
      _1130: x0 => x0.height,
      _1131: (x0,x1) => x0.lock(x1),
      _1150: x0 => new ResizeObserver(x0),
      _1153: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1153(f,arguments.length,x0,x1) }),
      _1161: x0 => x0.length,
      _1162: x0 => x0.iterator,
      _1163: x0 => x0.Segmenter,
      _1164: x0 => x0.v8BreakIterator,
      _1165: (x0,x1) => new Intl.Segmenter(x0,x1),
      _1166: x0 => x0.done,
      _1167: x0 => x0.value,
      _1168: x0 => x0.index,
      _1172: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _1173: (x0,x1) => x0.adoptText(x1),
      _1174: x0 => x0.first(),
      _1175: x0 => x0.next(),
      _1176: x0 => x0.current(),
      _1182: x0 => x0.hostElement,
      _1183: x0 => x0.viewConstraints,
      _1186: x0 => x0.maxHeight,
      _1187: x0 => x0.maxWidth,
      _1188: x0 => x0.minHeight,
      _1189: x0 => x0.minWidth,
      _1190: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1190(f,arguments.length,x0) }),
      _1191: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1191(f,arguments.length,x0) }),
      _1192: (x0,x1) => ({addView: x0,removeView: x1}),
      _1193: x0 => x0.loader,
      _1194: () => globalThis._flutter,
      _1195: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1196: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1196(f,arguments.length,x0) }),
      _1197: f => finalizeWrapper(f, function() { return dartInstance.exports._1197(f,arguments.length) }),
      _1198: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _1199: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1199(f,arguments.length,x0) }),
      _1200: x0 => ({runApp: x0}),
      _1201: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1201(f,arguments.length,x0,x1) }),
      _1202: x0 => x0.length,
      _1203: () => globalThis.window.ImageDecoder,
      _1204: x0 => x0.tracks,
      _1206: x0 => x0.completed,
      _1208: x0 => x0.image,
      _1214: x0 => x0.displayWidth,
      _1215: x0 => x0.displayHeight,
      _1216: x0 => x0.duration,
      _1219: x0 => x0.ready,
      _1220: x0 => x0.selectedTrack,
      _1221: x0 => x0.repetitionCount,
      _1222: x0 => x0.frameCount,
      _1265: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1265(f,arguments.length,x0) }),
      _1266: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1267: (x0,x1,x2) => x0.postMessage(x1,x2),
      _1268: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _1269: (x0,x1) => x0.getItem(x1),
      _1270: (x0,x1,x2) => x0.setItem(x1,x2),
      _1271: (x0,x1) => x0.querySelectorAll(x1),
      _1272: (x0,x1) => x0.removeChild(x1),
      _1273: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1273(f,arguments.length,x0) }),
      _1274: (x0,x1) => x0.forEach(x1),
      _1275: x0 => x0.preventDefault(),
      _1276: (x0,x1) => x0.item(x1),
      _1277: () => new FileReader(),
      _1278: (x0,x1) => x0.readAsText(x1),
      _1279: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1279(f,arguments.length,x0) }),
      _1280: () => globalThis.initializeGA(),
      _1282: (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33) => ({screen: x0,event_category: x1,event_label: x2,send_to: x3,value: x4,non_interaction: x5,user_app: x6,user_build: x7,user_platform: x8,devtools_platform: x9,devtools_chrome: x10,devtools_version: x11,ide_launched: x12,flutter_client_id: x13,is_external_build: x14,is_embedded: x15,g3_username: x16,ide_launched_feature: x17,is_wasm: x18,ui_duration_micros: x19,raster_duration_micros: x20,shader_compilation_duration_micros: x21,cpu_sample_count: x22,cpu_stack_depth: x23,trace_event_count: x24,heap_diff_objects_before: x25,heap_diff_objects_after: x26,heap_objects_total: x27,root_set_count: x28,row_count: x29,inspector_tree_controller_id: x30,android_app_id: x31,ios_bundle_id: x32,is_v2_inspector: x33}),
      _1283: x0 => x0.screen,
      _1284: x0 => x0.user_app,
      _1285: x0 => x0.user_build,
      _1286: x0 => x0.user_platform,
      _1287: x0 => x0.devtools_platform,
      _1288: x0 => x0.devtools_chrome,
      _1289: x0 => x0.devtools_version,
      _1290: x0 => x0.ide_launched,
      _1292: x0 => x0.is_external_build,
      _1293: x0 => x0.is_embedded,
      _1294: x0 => x0.g3_username,
      _1295: x0 => x0.ide_launched_feature,
      _1296: x0 => x0.is_wasm,
      _1297: x0 => x0.ui_duration_micros,
      _1298: x0 => x0.raster_duration_micros,
      _1299: x0 => x0.shader_compilation_duration_micros,
      _1300: x0 => x0.cpu_sample_count,
      _1301: x0 => x0.cpu_stack_depth,
      _1302: x0 => x0.trace_event_count,
      _1303: x0 => x0.heap_diff_objects_before,
      _1304: x0 => x0.heap_diff_objects_after,
      _1305: x0 => x0.heap_objects_total,
      _1306: x0 => x0.root_set_count,
      _1307: x0 => x0.row_count,
      _1308: x0 => x0.inspector_tree_controller_id,
      _1309: x0 => x0.android_app_id,
      _1310: x0 => x0.ios_bundle_id,
      _1311: x0 => x0.is_v2_inspector,
      _1313: (x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29) => ({description: x0,fatal: x1,user_app: x2,user_build: x3,user_platform: x4,devtools_platform: x5,devtools_chrome: x6,devtools_version: x7,ide_launched: x8,flutter_client_id: x9,is_external_build: x10,is_embedded: x11,g3_username: x12,ide_launched_feature: x13,is_wasm: x14,ui_duration_micros: x15,raster_duration_micros: x16,shader_compilation_duration_micros: x17,cpu_sample_count: x18,cpu_stack_depth: x19,trace_event_count: x20,heap_diff_objects_before: x21,heap_diff_objects_after: x22,heap_objects_total: x23,root_set_count: x24,row_count: x25,inspector_tree_controller_id: x26,android_app_id: x27,ios_bundle_id: x28,is_v2_inspector: x29}),
      _1314: x0 => x0.user_app,
      _1315: x0 => x0.user_build,
      _1316: x0 => x0.user_platform,
      _1317: x0 => x0.devtools_platform,
      _1318: x0 => x0.devtools_chrome,
      _1319: x0 => x0.devtools_version,
      _1320: x0 => x0.ide_launched,
      _1322: x0 => x0.is_external_build,
      _1323: x0 => x0.is_embedded,
      _1324: x0 => x0.g3_username,
      _1325: x0 => x0.ide_launched_feature,
      _1326: x0 => x0.is_wasm,
      _1342: () => globalThis.getDevToolsPropertyID(),
      _1343: () => globalThis.hookupListenerForGA(),
      _1344: (x0,x1,x2) => globalThis.gtag(x0,x1,x2),
      _1346: x0 => x0.event_category,
      _1347: x0 => x0.event_label,
      _1349: x0 => x0.value,
      _1350: x0 => x0.non_interaction,
      _1353: x0 => x0.description,
      _1354: x0 => x0.fatal,
      _1355: (x0,x1) => x0.createElement(x1),
      _1356: x0 => new Blob(x0),
      _1357: x0 => globalThis.URL.createObjectURL(x0),
      _1358: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _1359: (x0,x1) => x0.append(x1),
      _1360: x0 => x0.click(),
      _1361: x0 => x0.remove(),
      _1362: x0 => x0.createRange(),
      _1363: (x0,x1) => x0.selectNode(x1),
      _1364: x0 => x0.getSelection(),
      _1365: x0 => x0.removeAllRanges(),
      _1366: (x0,x1) => x0.addRange(x1),
      _1367: (x0,x1) => x0.createElement(x1),
      _1368: (x0,x1) => x0.append(x1),
      _1369: (x0,x1,x2) => x0.insertRule(x1,x2),
      _1370: (x0,x1) => x0.add(x1),
      _1371: x0 => x0.preventDefault(),
      _1372: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1372(f,arguments.length,x0) }),
      _1373: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _1374: () => globalThis.window.navigator.userAgent,
      _1375: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1375(f,arguments.length,x0) }),
      _1376: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _1377: (x0,x1,x2,x3) => x0.removeEventListener(x1,x2,x3),
      _1382: (x0,x1) => x0.closest(x1),
      _1383: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1384: x0 => x0.decode(),
      _1385: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1386: (x0,x1,x2) => x0.setRequestHeader(x1,x2),
      _1387: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1387(f,arguments.length,x0) }),
      _1388: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1388(f,arguments.length,x0) }),
      _1389: x0 => x0.send(),
      _1390: () => new XMLHttpRequest(),
      _1391: (x0,x1) => x0.querySelector(x1),
      _1392: (x0,x1) => x0.appendChild(x1),
      _1393: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1393(f,arguments.length,x0) }),
      _1394: Date.now,
      _1396: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1397: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1398: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1399: () => typeof dartUseDateNowForTicks !== "undefined",
      _1400: () => 1000 * performance.now(),
      _1401: () => Date.now(),
      _1402: () => {
        // On browsers return `globalThis.location.href`
        if (globalThis.location != null) {
          return globalThis.location.href;
        }
        return null;
      },
      _1403: () => {
        return typeof process != "undefined" &&
               Object.prototype.toString.call(process) == "[object process]" &&
               process.platform == "win32"
      },
      _1404: () => new WeakMap(),
      _1405: (map, o) => map.get(o),
      _1406: (map, o, v) => map.set(o, v),
      _1407: x0 => new WeakRef(x0),
      _1408: x0 => x0.deref(),
      _1415: () => globalThis.WeakRef,
      _1419: s => JSON.stringify(s),
      _1420: s => printToConsole(s),
      _1421: (o, p, r) => o.replaceAll(p, () => r),
      _1422: (o, p, r) => o.replace(p, () => r),
      _1423: Function.prototype.call.bind(String.prototype.toLowerCase),
      _1424: s => s.toUpperCase(),
      _1425: s => s.trim(),
      _1426: s => s.trimLeft(),
      _1427: s => s.trimRight(),
      _1428: (string, times) => string.repeat(times),
      _1429: Function.prototype.call.bind(String.prototype.indexOf),
      _1430: (s, p, i) => s.lastIndexOf(p, i),
      _1431: (string, token) => string.split(token),
      _1432: Object.is,
      _1433: o => o instanceof Array,
      _1434: (a, i) => a.push(i),
      _1435: (a, i) => a.splice(i, 1)[0],
      _1437: (a, l) => a.length = l,
      _1438: a => a.pop(),
      _1439: (a, i) => a.splice(i, 1),
      _1440: (a, s) => a.join(s),
      _1441: (a, s, e) => a.slice(s, e),
      _1442: (a, s, e) => a.splice(s, e),
      _1443: (a, b) => a == b ? 0 : (a > b ? 1 : -1),
      _1444: a => a.length,
      _1445: (a, l) => a.length = l,
      _1446: (a, i) => a[i],
      _1447: (a, i, v) => a[i] = v,
      _1449: o => o instanceof ArrayBuffer,
      _1450: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1452: o => o instanceof Uint8Array,
      _1453: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1454: o => o instanceof Int8Array,
      _1455: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1456: o => o instanceof Uint8ClampedArray,
      _1457: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1458: o => o instanceof Uint16Array,
      _1459: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1460: o => o instanceof Int16Array,
      _1461: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1462: o => o instanceof Uint32Array,
      _1463: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1464: o => o instanceof Int32Array,
      _1465: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1467: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1468: o => o instanceof Float32Array,
      _1469: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1470: o => o instanceof Float64Array,
      _1471: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1472: (t, s) => t.set(s),
      _1474: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1475: o => o.byteLength,
      _1476: o => o.buffer,
      _1477: o => o.byteOffset,
      _1478: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1479: (b, o) => new DataView(b, o),
      _1480: (b, o, l) => new DataView(b, o, l),
      _1481: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1482: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1483: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1484: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1485: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1486: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1487: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1488: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1489: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1490: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1491: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1492: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1495: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1496: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1497: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1498: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1499: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1500: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1513: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1514: (handle) => clearTimeout(handle),
      _1515: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1516: (handle) => clearInterval(handle),
      _1517: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1518: () => Date.now(),
      _1523: o => Object.keys(o),
      _1524: (x0,x1) => new WebSocket(x0,x1),
      _1525: (x0,x1) => x0.send(x1),
      _1526: (x0,x1,x2) => x0.close(x1,x2),
      _1528: x0 => x0.close(),
      _1529: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      _1530: (x0,x1) => globalThis.fetch(x0,x1),
      _1531: (x0,x1) => x0.get(x1),
      _1532: f => finalizeWrapper(f, function(x0,x1,x2) { return dartInstance.exports._1532(f,arguments.length,x0,x1,x2) }),
      _1533: (x0,x1) => x0.forEach(x1),
      _1534: x0 => x0.abort(),
      _1535: () => new AbortController(),
      _1536: x0 => x0.getReader(),
      _1537: x0 => x0.read(),
      _1538: x0 => x0.cancel(),
      _1539: x0 => ({withCredentials: x0}),
      _1540: (x0,x1) => new EventSource(x0,x1),
      _1541: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1541(f,arguments.length,x0) }),
      _1542: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1542(f,arguments.length,x0) }),
      _1543: x0 => x0.close(),
      _1544: (x0,x1,x2) => ({method: x0,body: x1,credentials: x2}),
      _1545: (x0,x1,x2) => x0.fetch(x1,x2),
      _1548: () => new XMLHttpRequest(),
      _1549: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1550: x0 => x0.send(),
      _1552: (x0,x1) => x0.readAsArrayBuffer(x1),
      _1558: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1558(f,arguments.length,x0) }),
      _1559: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1559(f,arguments.length,x0) }),
      _1564: x0 => ({body: x0}),
      _1565: (x0,x1) => new Notification(x0,x1),
      _1566: () => globalThis.Notification.requestPermission(),
      _1567: x0 => x0.close(),
      _1568: x0 => x0.reload(),
      _1569: (x0,x1) => x0.groupCollapsed(x1),
      _1570: (x0,x1) => x0.log(x1),
      _1571: x0 => x0.groupEnd(),
      _1572: (x0,x1) => x0.warn(x1),
      _1573: (x0,x1) => x0.error(x1),
      _1574: x0 => x0.measureUserAgentSpecificMemory(),
      _1575: x0 => x0.bytes,
      _1585: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1585(f,arguments.length,x0) }),
      _1586: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1586(f,arguments.length,x0) }),
      _1587: x0 => x0.blur(),
      _1588: (x0,x1) => x0.replace(x1),
      _1589: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1599: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _1600: (x0,x1) => x0.exec(x1),
      _1601: (x0,x1) => x0.test(x1),
      _1602: x0 => x0.pop(),
      _1604: o => o === undefined,
      _1606: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _1608: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _1609: o => o instanceof RegExp,
      _1610: (l, r) => l === r,
      _1611: o => o,
      _1612: o => o,
      _1613: o => o,
      _1614: b => !!b,
      _1615: o => o.length,
      _1617: (o, i) => o[i],
      _1618: f => f.dartFunction,
      _1619: () => ({}),
      _1620: () => [],
      _1622: () => globalThis,
      _1623: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _1624: (o, p) => p in o,
      _1625: (o, p) => o[p],
      _1626: (o, p, v) => o[p] = v,
      _1627: (o, m, a) => o[m].apply(o, a),
      _1629: o => String(o),
      _1630: (p, s, f) => p.then(s, f),
      _1631: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        return 17;
      },
      _1632: o => [o],
      _1633: (o0, o1) => [o0, o1],
      _1634: (o0, o1, o2) => [o0, o1, o2],
      _1635: (o0, o1, o2, o3) => [o0, o1, o2, o3],
      _1636: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1637: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1638: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI16ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1639: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI16ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1640: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1641: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1642: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1643: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1644: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1645: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1646: x0 => new ArrayBuffer(x0),
      _1647: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _1648: x0 => x0.input,
      _1649: x0 => x0.index,
      _1650: x0 => x0.groups,
      _1651: x0 => x0.flags,
      _1652: x0 => x0.multiline,
      _1653: x0 => x0.ignoreCase,
      _1654: x0 => x0.unicode,
      _1655: x0 => x0.dotAll,
      _1656: (x0,x1) => { x0.lastIndex = x1 },
      _1657: (o, p) => p in o,
      _1658: (o, p) => o[p],
      _1661: x0 => x0.random(),
      _1664: () => globalThis.Math,
      _1665: Function.prototype.call.bind(Number.prototype.toString),
      _1666: Function.prototype.call.bind(BigInt.prototype.toString),
      _1667: Function.prototype.call.bind(Number.prototype.toString),
      _1668: (d, digits) => d.toFixed(digits),
      _1671: (d, precision) => d.toPrecision(precision),
      _1672: () => globalThis.document,
      _1673: () => globalThis.window,
      _1678: (x0,x1) => { x0.height = x1 },
      _1680: (x0,x1) => { x0.width = x1 },
      _1683: x0 => x0.head,
      _1684: x0 => x0.classList,
      _1688: (x0,x1) => { x0.innerText = x1 },
      _1689: x0 => x0.style,
      _1691: x0 => x0.sheet,
      _1692: x0 => x0.src,
      _1693: (x0,x1) => { x0.src = x1 },
      _1694: x0 => x0.naturalWidth,
      _1695: x0 => x0.naturalHeight,
      _1702: x0 => x0.offsetX,
      _1703: x0 => x0.offsetY,
      _1704: x0 => x0.button,
      _1711: x0 => x0.status,
      _1712: (x0,x1) => { x0.responseType = x1 },
      _1714: x0 => x0.response,
      _1763: (x0,x1) => { x0.responseType = x1 },
      _1764: x0 => x0.response,
      _1839: x0 => x0.style,
      _2316: (x0,x1) => { x0.src = x1 },
      _2323: (x0,x1) => { x0.allow = x1 },
      _2335: x0 => x0.contentWindow,
      _2768: (x0,x1) => { x0.accept = x1 },
      _2782: x0 => x0.files,
      _2808: (x0,x1) => { x0.multiple = x1 },
      _2826: (x0,x1) => { x0.type = x1 },
      _3524: (x0,x1) => { x0.dropEffect = x1 },
      _3529: x0 => x0.files,
      _3541: x0 => x0.dataTransfer,
      _3545: () => globalThis.window,
      _3587: x0 => x0.location,
      _3588: x0 => x0.history,
      _3604: x0 => x0.parent,
      _3606: x0 => x0.navigator,
      _3861: x0 => x0.isSecureContext,
      _3862: x0 => x0.crossOriginIsolated,
      _3865: x0 => x0.performance,
      _3870: x0 => x0.localStorage,
      _3878: x0 => x0.origin,
      _3887: x0 => x0.pathname,
      _3901: x0 => x0.state,
      _3926: x0 => x0.message,
      _3988: x0 => x0.appVersion,
      _3989: x0 => x0.platform,
      _3992: x0 => x0.userAgent,
      _3993: x0 => x0.vendor,
      _4043: x0 => x0.data,
      _4044: x0 => x0.origin,
      _4416: x0 => x0.readyState,
      _4425: x0 => x0.protocol,
      _4429: (x0,x1) => { x0.binaryType = x1 },
      _4432: x0 => x0.code,
      _4433: x0 => x0.reason,
      _6100: x0 => x0.type,
      _6141: x0 => x0.signal,
      _6199: x0 => x0.parentNode,
      _6213: () => globalThis.document,
      _6295: x0 => x0.body,
      _6338: x0 => x0.activeElement,
      _6972: x0 => x0.offsetX,
      _6973: x0 => x0.offsetY,
      _7058: x0 => x0.key,
      _7059: x0 => x0.code,
      _7060: x0 => x0.location,
      _7061: x0 => x0.ctrlKey,
      _7062: x0 => x0.shiftKey,
      _7063: x0 => x0.altKey,
      _7064: x0 => x0.metaKey,
      _7065: x0 => x0.repeat,
      _7066: x0 => x0.isComposing,
      _7972: x0 => x0.value,
      _7974: x0 => x0.done,
      _8154: x0 => x0.size,
      _8155: x0 => x0.type,
      _8162: x0 => x0.name,
      _8163: x0 => x0.lastModified,
      _8168: x0 => x0.length,
      _8174: x0 => x0.result,
      _8669: x0 => x0.url,
      _8671: x0 => x0.status,
      _8673: x0 => x0.statusText,
      _8674: x0 => x0.headers,
      _8675: x0 => x0.body,
      _10757: (x0,x1) => { x0.backgroundColor = x1 },
      _10803: (x0,x1) => { x0.border = x1 },
      _11081: (x0,x1) => { x0.display = x1 },
      _11245: (x0,x1) => { x0.height = x1 },
      _11935: (x0,x1) => { x0.width = x1 },
      _13022: () => globalThis.console,

    };

    const baseImports = {
      dart2wasm: dart2wasm,
      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
      S: new Proxy({}, { get(_, prop) { return prop; } }),

    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      "intoCharCodeArray": (s, a, start) => {
        if (s === '') return 0;

        const write = dartInstance.exports.$wasmI16ArraySet;
        for (var i = 0; i < s.length; ++i) {
          write(a, start++, s.charCodeAt(i));
        }
        return s.length;
      },
      "test": (s) => typeof s == "string",
    };


    

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}
