# Cyberpunk Ultra+ Control

## Note: v5.5.0 of Cyberpunk Ultra+ is the last version that is open source.

I initially open sourced my mods thinking that people could learn how they work, we could share the knowledge, and there have been some good contributions.

However what actually happened, was people started incorporating Ultra+ settings, which are extremely easy to spot, into their Engine.ini mods combined with 150 found settings from Reddit, and without any attribution.

I think users being faced with 50 "performance optimization" and "ultimate visuals" mods shouting loudly that they're the best, is frankly just confusing and frustrating.

On a technical level, there aren't really 50 ways to tune performance or maximise visuals. There probably aren't even 5, or 2.

In the meantime Ultra+ has turned into a team of talented developers and artists working on different games, each having ownership of their own work, yet under the Ultra+ brand, and at a high quality people have come to expect from these mods.

While I still absolutely welcome contribution, this is now done in private by the team on [The Ultra Place](https://discord.gg/ultraplace) Discord. If you have contributed in the past, or would like to, please ping me (or one of our team) in the Discord 😊.

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
- [x] Stop separate denoiser enabling with NRD (finish PTNext enablement code/testing) or just save separate denoiser settings
- [ ] Fix sparkling skin with PTNext NRD
- [x] Document v4!
- [x] Move saved RIS into internal settings so it overrides the engine with DoLazy()
- [x] Fix window scaling for different resolutions
- [x] Auto-fix stuck weather?
- [x] Fully enable ReGIRDI + ReGIRGI
- [x] Auto-scale visual quality based on user-configurable Target FPS
- [x] Adjust sun shadow sharpness based on time of day (IRL dawn and dusk have more diffuse shadows) 
- [ ] ~~Auto-detect NSGDD and Vegetation LOD~~ can't be done without using redscript
- [x] Saving of Ultra+'s mode (RTPT, PT20, samples, etc...)
- [x] Enable RTPT option (including changing the engine's ray tracing mode in real-time)
- [x] Add streaming options (? vanilla, medium, high)
- [x] Separate settings into separate file(s)
- [x] Remove options that are confusing or don't add any value
- [x] Put all feature / distance / etc. tabs onto one page

## Where to find me

You can find me:
- in #mod-dev-chat of the Cyberpunk 2077 Modding Discord https://discord.com/invite/redmodding
- in Digital Dreams' Discord https://discord.com/invite/dcb9Rv7W6t
