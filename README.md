<!--
http://www.apache.org/licenses/LICENSE-2.0.txt


Copyright 2015 Intel Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
# Snap publisher plugin - Prometheus

Snap Prometheus plugin written in Go supports publishing ingested time series data points into [Prometheus](http://prometheus.io).
It's used in the [Snap framework](http://github.com:intelsdi-x/snap).


1. [Getting Started](#getting-started)
    * [System Requirements](#system-requirements)
    * [Installation](#installation)
    * [Configuration and Usage](#configuration-and-usage)
    * [Install and run OpenTSDB](#install-and-run-opentsdb)
2. [Documentation](#documentation)
    * [Examples](#examples)
    * [Roadmap](#roadmap)
3. [Community Support](#community-support)
4. [Contributing](#contributing)
5. [License and Authors](#license-and-authors)
6. [Thank You](#thank-you)


## Getting Started
To get started, you'll need Snap and OpenTSDB running to receive and aggregate sampling data points.

### System Requirements
* [golang 1.6+](https://golang.org/dl/) (needed only for building)
* [snap](https://github.com/intelsdi-x/snap)

### Operating systems
All OSs currently supported by Snap:
* Linux/amd64
* Darwin/amd64

### Installation
#### Download prometheus plugin binary:
You can get the pre-built binaries for your OS and architecture at plugin's [GitHub Releases](https://github.com/adragomir/snap-plugin-publisher-prometheus/releases) page.

#### To build the plugin binary:
Fork https://github.com/intelsdi-x/snap-plugin-publisher-prometheus

Clone repo into `$GOPATH/src/github.com/intelsdi-x/`:

```
$ git clone https://github.com/<yourGithubID>/snap-plugin-publisher-prometheus.git
```

Build the plugin by running make within the cloned repo:
```
$ make
```
This builds the plugin in `./build`

### Configuration and Usage
* Set up the [Snap framework](https://github.com/intelsdi-x/snap/blob/master/README.md#getting-started)

## Documentation

TODO

### Examples

Example of running [psutil collector plugin](https://github.com/intelsdi-x/snap-plugin-collector-psutil) and publishing data to Prometheus.

Set up the [Snap framework](https://github.com/intelsdi-x/snap/blob/master/README.md#getting-started)

Ensure [Snap daemon is running](https://github.com/intelsdi-x/snap#running-snap):
* initd: `service snap-telemetry start`
* systemd: `systemctl start snap-telemetry`
* command line: `sudo snapteld -l 1 -t 0 &`

Download and load Snap plugins (paths to binary files for Linux/amd64):
```
$ snaptel plugin load snap-plugin-publisher-prometheus
$ snaptel plugin load snap-plugin-collector-psutil
```

Create a [task manifest](https://github.com/intelsdi-x/snap/blob/master/docs/TASKS.md) (see [exemplary tasks](examples/tasks/)),
for example `psutil-prometheus.json` with following content:
```json
{
  "version": 1,
  "schedule": {
    "type": "simple",
    "interval": "10s"
  },
  "workflow": {
    "collect": {
      "metrics": {
        "/intel/psutil/load/load1": {},
        "/intel/psutil/load/load15": {},
        "/intel/psutil/load/load5": {},
        "/intel/psutil/vm/available": {},
        "/intel/psutil/vm/free": {},
        "/intel/psutil/vm/used": {}
      },
      "publish": [
        {
          "plugin_name": "prometheus",
          "config": {
            "host": "127.0.0.1",
            "port": 80
          }
        }
      ]
    }
  }
}
```
Create a task:
```
$ snaptel task create -t psutil-prometheus.json
```

Watch created task:
```
$ snaptel task watch <task_id>
```

To stop previously created task:
```
$ snaptel task stop <task_id>
```

#### Limitations
This plugin only supports the "host" tag for now.

### Roadmap
As we launch this plugin, we do not have any outstanding requirements for the next release. If you have a feature request, please add it as an [issue](https://github.com/adragomir/snap-plugin-publisher-prometheus/issues).

## Community Support
This repository is one of **many** plugins in **Snap**, a powerful telemetry framework. See the full project at http://github.com/intelsdi-x/snap To reach out to other users, head to the [main framework](https://github.com/intelsdi-x/snap#community-support)

## Contributing
We love contributions!

There's more than one way to give back, from examples to blogs to code updates. See our recommended process in [CONTRIBUTING.md](CONTRIBUTING.md).

## License
This is Open Source software released under the Apache 2.0 License. Please see the [LICENSE](LICENSE) file for full license details.

## Thank You
Your contribution is incredibly important to us.

