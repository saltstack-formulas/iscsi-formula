# Changelog

## [1.1.2](https://github.com/saltstack-formulas/iscsi-formula/compare/v1.1.1...v1.1.2) (2020-05-08)


### Bug Fixes

* **arch:** python-configshell-fb dependency problem ([914c71e](https://github.com/saltstack-formulas/iscsi-formula/commit/914c71e15ebefbbdb9b5f1216a6138b8a364a4c1))
* **arch:** update packages yamls ([c0e0e8c](https://github.com/saltstack-formulas/iscsi-formula/commit/c0e0e8c2a793c6aee4e8744f870f7b18e352bdc8))
* **libtofs:** “files_switch” mess up the variable exported by “map.jinja” [skip ci] ([1433aad](https://github.com/saltstack-formulas/iscsi-formula/commit/1433aad429907ec32c33a966b93a0f92a4662afc))


### Code Refactoring

* **kitchen:** rename arch pillar file ([aabba21](https://github.com/saltstack-formulas/iscsi-formula/commit/aabba21f2047b08d41ce570c971bc8fd81fa3841))


### Continuous Integration

* **archlinux:** py2 support removed in salt ([f78b48f](https://github.com/saltstack-formulas/iscsi-formula/commit/f78b48fb61f2025c61a873036a47f29071c37c79))
* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([0a6e18a](https://github.com/saltstack-formulas/iscsi-formula/commit/0a6e18a9f0163cd82b49b02bd5919796f5a8ea63))
* **kitchen:** avoid using bootstrap for `master` instances [skip ci] ([989f8ed](https://github.com/saltstack-formulas/iscsi-formula/commit/989f8edb6839e712e97ae207c296f15ff0d02511))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([cff2909](https://github.com/saltstack-formulas/iscsi-formula/commit/cff2909c264712f71ef6b36d39a1f63db98a6500))
* **workflows/commitlint:** add to repo [skip ci] ([d470fe1](https://github.com/saltstack-formulas/iscsi-formula/commit/d470fe15ecca0f4c124962aed29a4e7eacbc1761))
* workaround issues with newly introduced `amazonlinux-1` [skip ci] ([a0c7fec](https://github.com/saltstack-formulas/iscsi-formula/commit/a0c7feca6b882c8b1410ec961f3712796e63e769))


### Tests

* **suite:** update travis tests ([29175d3](https://github.com/saltstack-formulas/iscsi-formula/commit/29175d30e8ff74e3c7bab82efdcea04808007317))

## [1.1.1](https://github.com/saltstack-formulas/iscsi-formula/compare/v1.1.0...v1.1.1) (2020-01-12)


### Bug Fixes

* **jinja:** convert the value type properly to json ([e49e511](https://github.com/saltstack-formulas/iscsi-formula/commit/e49e5116661d17bc250f5b2a9ae273beda05a53f))
* **release.config.js:** use full commit hash in commit link [skip ci] ([93e410b](https://github.com/saltstack-formulas/iscsi-formula/commit/93e410be3751ed88f99515b1df76ac12a4231efd))


### Continuous Integration

* **gemfile:** restrict `train` gem version until upstream fix [skip ci] ([b279161](https://github.com/saltstack-formulas/iscsi-formula/commit/b279161d1a2b70f5818367d4ca09fd34b5af6b60))
* **kitchen:** use `debian-10-master-py3` instead of `develop` [skip ci] ([d03c6b8](https://github.com/saltstack-formulas/iscsi-formula/commit/d03c6b8eb50777260172144b601ad01697fda8ad))
* **kitchen:** use `develop` image until `master` is ready (`amazonlinux`) [skip ci] ([bcad2ef](https://github.com/saltstack-formulas/iscsi-formula/commit/bcad2efec4344ccdff3b0bd07ad4d90f991b944c))
* **kitchen+travis:** upgrade matrix after `2019.2.2` release [skip ci] ([0267684](https://github.com/saltstack-formulas/iscsi-formula/commit/02676842d18d38403255b64b59bf33489d9d9f12))
* **travis:** apply changes from build config validation [skip ci] ([591cb81](https://github.com/saltstack-formulas/iscsi-formula/commit/591cb81c79a6c97675ca4135a3b42bc5bc23aeeb))
* **travis:** opt-in to `dpl v2` to complete build config validation [skip ci] ([6472beb](https://github.com/saltstack-formulas/iscsi-formula/commit/6472beb85ad8ea80f5e1a209186ce23fbbe40238))
* **travis:** quote pathspecs used with `git ls-files` [skip ci] ([ed20ed1](https://github.com/saltstack-formulas/iscsi-formula/commit/ed20ed136b4864c5618aa8c9df26d84f955972e1))
* **travis:** run `shellcheck` during lint job [skip ci] ([455fe13](https://github.com/saltstack-formulas/iscsi-formula/commit/455fe134e1d52f233f3bf4788b90e64e1820abdc))
* **travis:** update `salt-lint` config for `v0.0.10` [skip ci] ([48c21d8](https://github.com/saltstack-formulas/iscsi-formula/commit/48c21d8a17ddc3e49941da2d409ac6168a3bccc2))
* **travis:** use `major.minor` for `semantic-release` version [skip ci] ([b9aaf44](https://github.com/saltstack-formulas/iscsi-formula/commit/b9aaf44e717d5de9e2bc41fa6cfcb013550f1802))
* **travis:** use build config validation (beta) [skip ci] ([78614cd](https://github.com/saltstack-formulas/iscsi-formula/commit/78614cd370688bbad511ed1340758aed3a37953d))


### Documentation

* **contributing:** remove to use org-level file instead [skip ci] ([06dae86](https://github.com/saltstack-formulas/iscsi-formula/commit/06dae861d61dbdc86e3aeec8239557378c8f8101))
* **readme:** update link to `CONTRIBUTING` [skip ci] ([c1b1316](https://github.com/saltstack-formulas/iscsi-formula/commit/c1b13164d0b244041fc16cff58a8f3b9f3901355))


### Performance Improvements

* **travis:** improve `salt-lint` invocation [skip ci] ([a49d419](https://github.com/saltstack-formulas/iscsi-formula/commit/a49d41989afbbd880ed050c19d53ff7ae91115d5))

# [1.1.0](https://github.com/saltstack-formulas/iscsi-formula/compare/v1.0.2...v1.1.0) (2019-10-12)


### Bug Fixes

* **clean.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/f5c57db))
* **clean.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/08f0d08))
* **clean.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/d3e4aa2))
* **ctld.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/f2f6f4c))
* **ietd.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/36922cc))
* **iscsi.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/ba00ccf))
* **isns.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/fd87bf8))
* **lio.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/94c95f5))
* **open-iscsi.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/3b0b12b))
* **rubocop:** add fixes using `rubocop --safe-auto-correct` ([](https://github.com/saltstack-formulas/iscsi-formula/commit/d49d3b8))
* **tgtd.tmpl:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/iscsi-formula/commit/cf38af1))


### Features

* **semantic-release:** complete for this formula ([](https://github.com/saltstack-formulas/iscsi-formula/commit/4f27ae9))

## [1.0.2](https://github.com/saltstack-formulas/iscsi-formula/compare/v1.0.1...v1.0.2) (2019-10-07)


### Bug Fixes

* **iscsi.conf:** adjust jinja rendering ([98e29d8](https://github.com/saltstack-formulas/iscsi-formula/commit/98e29d8))
* **jinja:** fix generated iscsi.conf ([1def94b](https://github.com/saltstack-formulas/iscsi-formula/commit/1def94b))


### Code Refactoring

* **config:** only create conf-file if pillar  data ([1645c53](https://github.com/saltstack-formulas/iscsi-formula/commit/1645c53))

## [1.0.1](https://github.com/saltstack-formulas/iscsi-formula/compare/v1.0.0...v1.0.1) (2019-10-05)


### Documentation

* **readme:** fix formatting ([40dd6ef](https://github.com/saltstack-formulas/iscsi-formula/commit/40dd6ef))
* **readme:** update scope heading ([840b389](https://github.com/saltstack-formulas/iscsi-formula/commit/840b389))

# 1.0.0 (2019-10-04)


### Bug Fixes

* **arch:** harden jinja for archlinux ([4ec440c](https://github.com/saltstack-formulas/iscsi-formula/commit/4ec440c))
* **archlinux:** update osfamilymap ([ea82c99](https://github.com/saltstack-formulas/iscsi-formula/commit/ea82c99))
* **clean:** fix clean kernel state ([a31079c](https://github.com/saltstack-formulas/iscsi-formula/commit/a31079c))
* **clean:** fix clean states ([f4224fc](https://github.com/saltstack-formulas/iscsi-formula/commit/f4224fc))
* **config:** only generate custom config if pillar data supplied ([8664023](https://github.com/saltstack-formulas/iscsi-formula/commit/8664023))
* **defaults:** fix username on archlinux ([6dfa8a1](https://github.com/saltstack-formulas/iscsi-formula/commit/6dfa8a1))
* **freebsd:** loader.conf is existing file ([d4d176f](https://github.com/saltstack-formulas/iscsi-formula/commit/d4d176f))
* **freebsd:** required changes for freebsd 11.2 ([1ef79ec](https://github.com/saltstack-formulas/iscsi-formula/commit/1ef79ec))
* **isns:** fix jinja in config file template ([8dfc993](https://github.com/saltstack-formulas/iscsi-formula/commit/8dfc993))
* **jinja:** fix error while parsing a flow ([8d9d959](https://github.com/saltstack-formulas/iscsi-formula/commit/8d9d959))
* **jinja:** fixes for file management ([2575062](https://github.com/saltstack-formulas/iscsi-formula/commit/2575062))
* **kernel:** fix kernel module states ([0fca2fa](https://github.com/saltstack-formulas/iscsi-formula/commit/0fca2fa))
* **kernelmod:** refactor kernel states ([9aac15a](https://github.com/saltstack-formulas/iscsi-formula/commit/9aac15a))
* **os:** better os mapping ([55e4cfb](https://github.com/saltstack-formulas/iscsi-formula/commit/55e4cfb))
* **os:** fix open-iscsi on archlinux ([43b2ad4](https://github.com/saltstack-formulas/iscsi-formula/commit/43b2ad4))
* **saltbug:** file.line is buggy; use file.prepend ([f72fe9e](https://github.com/saltstack-formulas/iscsi-formula/commit/f72fe9e))
* **saltbug:** fix for strange 'unless: <url>' bug ([5de113d](https://github.com/saltstack-formulas/iscsi-formula/commit/5de113d))
* **service:** only start service if enabled ([b8d8b7f](https://github.com/saltstack-formulas/iscsi-formula/commit/b8d8b7f))
* **suse:** service is called targetcli on Suse15 ([4f37896](https://github.com/saltstack-formulas/iscsi-formula/commit/4f37896))
* **target:** increase volsize and minor fixes ([9c50ef9](https://github.com/saltstack-formulas/iscsi-formula/commit/9c50ef9))
* **target:** some minor fixes ([ab04191](https://github.com/saltstack-formulas/iscsi-formula/commit/ab04191))
* **template:** comments not supported by json standard ([433d647](https://github.com/saltstack-formulas/iscsi-formula/commit/433d647))
* **tgt:** fix for tgtadm: invalid request ([de4b9f0](https://github.com/saltstack-formulas/iscsi-formula/commit/de4b9f0))
* **travis:** travis wants loop4-7 ([7671bec](https://github.com/saltstack-formulas/iscsi-formula/commit/7671bec))
* **ubuntu:** fix target service name on ubuntu ([36c63a7](https://github.com/saltstack-formulas/iscsi-formula/commit/36c63a7))
* **ubuntu:** update list of default packages ([bf99361](https://github.com/saltstack-formulas/iscsi-formula/commit/bf99361))


### Code Refactoring

* **formula:** align to template-formula & fix [#19](https://github.com/saltstack-formulas/iscsi-formula/issues/19) ([dfb5b27](https://github.com/saltstack-formulas/iscsi-formula/commit/dfb5b27))
* **osmaps:** add osfinger, osmap ([add55e0](https://github.com/saltstack-formulas/iscsi-formula/commit/add55e0))


### Documentation

* **archlinux:** add user to pillar.example ([4b09216](https://github.com/saltstack-formulas/iscsi-formula/commit/4b09216))
* **example:** update pillars for travis ([ffc2ddd](https://github.com/saltstack-formulas/iscsi-formula/commit/ffc2ddd))
* **lint:** fix lint errors & skip service on centos/travis ([1a6161f](https://github.com/saltstack-formulas/iscsi-formula/commit/1a6161f))
* **readme:** list all states ([930fb9e](https://github.com/saltstack-formulas/iscsi-formula/commit/930fb9e))
* **readme:** update description ([02cad31](https://github.com/saltstack-formulas/iscsi-formula/commit/02cad31))
* **readme:** update documentation re. targets ([c90f86d](https://github.com/saltstack-formulas/iscsi-formula/commit/c90f86d))
* **suse:** update pillar example packages ([ff54b33](https://github.com/saltstack-formulas/iscsi-formula/commit/ff54b33))
* **unused:** removing depreciated docs/ files ([118a2d6](https://github.com/saltstack-formulas/iscsi-formula/commit/118a2d6))


### Features

* **kernel:** advice re kernel upgrades ([77d3625](https://github.com/saltstack-formulas/iscsi-formula/commit/77d3625))


### Tests

* **arch/cent:** updated kitchen tests ([d519be1](https://github.com/saltstack-formulas/iscsi-formula/commit/d519be1))
* **lint:** fix yamllint errors ([2ab2b3e](https://github.com/saltstack-formulas/iscsi-formula/commit/2ab2b3e))
* **matrix:** choose appropriate os ([42d9f7a](https://github.com/saltstack-formulas/iscsi-formula/commit/42d9f7a))
* **travis:** add dependency to lvm; update pillar data ([fb694a0](https://github.com/saltstack-formulas/iscsi-formula/commit/fb694a0))
* **travis:** add travis yml ([828f827](https://github.com/saltstack-formulas/iscsi-formula/commit/828f827))
* **travis:** change loop0-3 to loop4-7 ([17d3833](https://github.com/saltstack-formulas/iscsi-formula/commit/17d3833))
* **travis:** fix centos7 kernel ([b562cb0](https://github.com/saltstack-formulas/iscsi-formula/commit/b562cb0))
* **travis:** fixup yamllint ([9690093](https://github.com/saltstack-formulas/iscsi-formula/commit/9690093))
* **travis:** no iscsi target package for amazonlinux ([d2f2b4e](https://github.com/saltstack-formulas/iscsi-formula/commit/d2f2b4e))
* **travis:** workaround travis nuances ([61502c9](https://github.com/saltstack-formulas/iscsi-formula/commit/61502c9))
