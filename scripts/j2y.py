#!/usr/bin/env python3
"""convert json to yaml
Documentation : https://pyyaml.org/wiki/PyYAML
Version 5.1 (2019-03-13) #254 – Allow to turn off sorting keys in Dumper
python3 json2yaml.py < ~/code/manpow/moneybug/mbuploader/support/offices.json
gist https://gist.github.com/noahcoad/46909253a5891af3699580b8f17baba8
"""


import json
import sys
import yaml


sys.stdout.write(yaml.dump(json.load(sys.stdin),sort_keys=False))
