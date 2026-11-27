// voice.js — Hina walks in, then a medium close-up talks with Piper voice + Rhubarb lip-sync.
// Mouth track comes from src/mouth.js (window.mouthAt(t), absolute audio time).
(() => {
  const U = 135;
  const WALK_END = 3.2;

  // A: wide street — walk in from the left.
  function shotA(t, lt, dur) {
    setTOD('day');
    const cam = { x: 960 + 20 * ease(seg(lt, 0, dur)), y: 560, zoom: 1.06 };
    SET.street(cam, t, {});

    const ta = onTwos(lt);
    const k = ease(seg(lt, 0, WALK_END));
    const x = lerp(-180, 1050, k);
    const walking = lt < WALK_END - .15;
    const f = faceAt(ta, [[0, 'determined'], [2.7, 'happy']]);

    hina(x, 965, U, {
      t: ta,
      turn: .65,
      face: f.face,
      walk: walking ? x / (2.6 * U) : undefined,
      walkAmt: walking ? 1 : 0,
      mouth: window.mouthAt(ta),
      blink: f.blink ?? autoBlink(ta, 7),
      look: [.12, .02],
      sway: [.018 * Math.sin(t * 1.7), 0]
    });
    camEnd();

    petals(t, { n: 26, size: 16, wind: 80, seed: 'voiceA' });
    if (lt > dur - .25) slashWipe(seg(lt, dur - .25, dur) * .5);
  }

  // B: medium close-up — talk. The mouth is driven by Rhubarb cues at absolute time.
  function shotB(t, lt, dur) {
    setTOD('day');
    const cam = { x: 960, y: 560, zoom: 1.55 };
    SET.street(cam, t, {});
    camEnd();

    const ta = onTwos(lt);
    const f = faceAt(ta, [[0, 'smile'], [2.4, 'neutral'], [4.6, 'smile']]);
    const gest = Math.sin(t * 2.1);

    G.save();
    G.fillStyle = 'rgba(255,236,242,.16)';
    G.fillRect(0, 0, W, H);
    G.restore();

    bust(DESIGNS.hina, 960, 500, 420, {
      t: ta,
      turn: .18,
      face: f.face,
      mouth: window.mouthAt(WALK_END + ta),
      blink: f.blink ?? autoBlink(ta, 9),
      look: [.08, .04],
      sway: [.01 * Math.sin(t * 1.6), 0],
      blush: f.face === 'smile' ? .35 : undefined
    });

    if (f.face === 'smile') sparkles(t, 960, 430, 430, 6, 'hinaVoice', .55);
    petals(t, { n: 14, size: 26, wind: 60, seed: 'voiceB', speed: 1.2 });
    if (lt > dur - .55) irisWipe(seg(lt, dur - .55, dur) * .5, 960, 470, { shape: 'star', col: '#2a2440' });
  }

  shots([[0, shotA], [WALK_END, shotB]]);

  window.overlayHook = (c, t) => {
    const line = (a, b, txt) => {
      if (t >= a && t < b) subtitle(c, txt, { alpha: clamp(Math.min((t - a) / .12, (b - t) / .12)) });
    };
    line(.2, 3.0, "Hi! I'm Hina.");
    line(3.2, 6.3, "I can walk, talk, and act in a 2D cartoon.");
    line(6.5, 10.0, "My voice is local. My mouth is synced with Rhubarb Lip Sync.");
  };
  window.EXTRA_FONTS.push(['800 54px "M PLUS Rounded 1c"', "Hi! I'm Hina. I can walk, talk, and act in a 2D cartoon. My voice is local. My mouth is synced with Rhubarb Lip Sync."]);
})();
