# Cyberpunk Ultra+ Control

## Goals
1. **Improve path tracing for as many people as possible**
  a. Speed up PT as much as possible ("Fast") so more people can play it
  b. Improve PT quality (reducing edge and boiling noise) for high-end PCs and those sensitive to PT noise
  c. Ray tracing + path tracing for AMD and lower-powered PCs
3. **Change modes in real-time** so users can see differences for themselves
4. **Fix PT / RT bugs** that can be fixed via engine manipulation
5. **Improve game stability**

![image](https://github.com/sammilucia/cyberpunk-ultra-plus/assets/3295286/a815f4b9-534d-4a2a-a2dc-b48feed671f6)

## Progress Video

[![Watch the video](https://img.youtube.com/vi/upY_oe_SJHQ/default.jpg)](https://youtu.be/upY_oe_SJHQ)

## Contributing

Please feel free to pitch in! I don't know LUA or ImGui and have limited time, so help is wonderful. This is a proof of concept.

## Done

## To Do
- [x] Stop saving/setting RR/NRD
- [x] Increase brightness of PTNext - test various methods esp. HitDistanceRoughnessScale and HitDistanceRoughnessExpScale (Hoonter suggests SceneScale  400–1000 Insane, 350 High, 250 Medium, 150 Low)
- [x] Increase quality of PT20 High/Insane
- [x] Fix sometimes overlayed shadow appears with PTNext
- [x] Fix separate denoiser being disabled briefly with CCTV and other conditions that aren't a game exit - can't repro
- [x] save SSR blending (move to features)
- [x] Scale BVH distance for Low (1000.0)/Med (2000.0)/High (3000.0)/Insane (5000.)
- [x] Fix/diff v4 smearing issue **Testing**
- [x] Fix PTNext flickering try increasing lights batch size to 512 or higher
- [x] Make separate denoiser enablement logic more robust
- [x] Fix bright vegetation
- [x] Slightly reduce PTNext build/shading candidates for High/Insane
- [x] Make NSGDD into a toggle so vram config can still be used
- [ ] stop separate denoiser enabling with NRD (finish PTNext enablement code/testing) or just save separate denoiser settings
- [ ] fix sparkling skin with PTNext NRD
- [ ] document v4!
- [ ] move saved RIS into internal settings so it overrides the engine with DoLazy()
- [ ] fix window scaling for different resolutions
- [ ] auto-fix stuck weather?
- [ ] ~~auto-detect NSGDD and Vegetation LOD~~ can't be done without using redscript

## Done
- Saving of Ultra+'s mode (RTPT, PT20, samples, etc...)
- Enable RTPT option (including changing the engine's ray tracing mode in real-time)
- Add streaming options (? vanilla, medium, high)
- Separate settings into separate file(s)
- Remove options that are confusing or don't add any value
- Put all feature / distance / etc. tabs onto one page

## Where to find me

You can find me:
- in #mod-dev-chat of the Cyberpunk 2077 Modding Discord https://discord.com/invite/redmodding
- in Digital Dreams' Discord https://discord.com/invite/dcb9Rv7W6t
