---
title: Web Interface
---

The FruitNanny is accessed via a web interface. It is desinged as *single-page
application* and written with [Vue.js](https://vuejs.org/) and the Material
Design framework [Vuetify](https://vuetifyjs.com/en/).

## GitHub Repository

The UI is developed in its own GitHub repository. Please report any
[issues or feature requests](https://github.com/fruitnanny/fruitnanny-ui/issues)
there.

:material-github: [fruitnanny/fruitnanny-ui](https://github.com/fruitnanny/fruitnanny-ui)


## Requirements

The following development tools are required:

 - [node.js](https://nodejs.org/en/)

```bash
# Tools for building the Debian package
sudo apt install devscripts
```


## Development

The source code is written in [TypeScript](https://www.typescriptlang.org/).
Vue components are written as [single-file components](https://vuejs.org/v2/guide/single-file-components.html)
using [vue-class-components](https://github.com/vuejs/vue-class-component)
and [vue-property-decorator](https://github.com/kaorun343/vue-property-decorator)
to leverage ES6 class syntax.

A special requirement for the FruitNanny web UI is the full-offline
capability. This means the web UI needs to work in an full-offline scenario
where the Raspberry Pi has no Internet connection. This is requires for the
FruitNanny to work in hotspot mode.

```bash
# Clone git repository
git clone https://github.com/fruitnanny/fruitnanny-ui

cd fruitnanny-ui/

# Install dependencies
npm install

# Run development server
npm run serve
```


### Plugins

The FruitNanny UI uses multiple Vue.js plugins in `src/plugins/`:


**Router**
: We use the standard [vue-router](https://router.vuejs.org/). The routing
  table is defined in this plugin module.

**Vuetify**
: Configures the Material Design color palette and dark mode.

**Notify**
: Custom plugin for a centralized management of Material Design snackbar
  notifications. This plugin provides a `$notify` property to all Vue
  components that can be used to send global notifications.


### Persistent Configuration

User-specific settings are stored in the browser
[LocalStorage](https://developer.mozilla.org/de/docs/Web/API/Window/localStorage).
The centralized API for managing user settings is the `src/settings.ts`
module.


## Release

The web UI is released as Debian package. The release process is as follows:

```bash
# Update changelog
dch
```

The version numbering is `<year>.<month>.<patch>`. We do **not** use semantic
versioning because we do not give guarantees about API compatibility.

```bash
# Build Debian package
make deb
```

The Debian package will install the Vue.js production build of the app into
`/usr/share/fruitnanny-ui`. The web directory will be used as web root by the
`fruitnanny-api` package.
