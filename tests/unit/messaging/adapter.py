# Copyright 2016 Hewlett Packard Enterprise Development Company LP
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
from monasca_transform.messaging.adapter import MessageAdapter
import simport


class DummyAdapter(MessageAdapter):

    adapter_impl = None

    metric_list = []

    @staticmethod
    def init():
        # object to keep track of offsets
        DummyAdapter.adapter_impl = simport.load(
            "tests.unit.messaging.adapter:DummyAdapter")()

    def do_send_metric(self, metric):
        self.metric_list.append(metric)

    @staticmethod
    def send_metric(metric):
        if not DummyAdapter.adapter_impl:
            DummyAdapter.init()
        DummyAdapter.adapter_impl.do_send_metric(metric)
