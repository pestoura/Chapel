/*
 * Copyright 2020 Hewlett Packard Enterprise Development LP
 * Copyright 2004-2019 Cray Inc.
 * Other additional copyright holders may be indicated within.
 *
 * The entirety of this work is licensed under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef PB_MESSAGE_HH
#define PB_MESSAGE_HH

#include <string>
#include <vector>

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/wire_format.h>

namespace chapel {

  using namespace std;
  using namespace google::protobuf;
  using namespace google::protobuf::compiler;
  using namespace google::protobuf::io;

  class FieldGeneratorBase;

  class MessageGenerator {
   public:
    MessageGenerator(const Descriptor* descriptor);
    ~MessageGenerator();

    void Generate(Printer* printer);

   private:
    const Descriptor* descriptor_;

    FieldGeneratorBase* CreateFieldGeneratorInternal(
    const FieldDescriptor* descriptor);

    string record_name();
  };

}  // namespace chapel

#endif  // PB_MESSAGE_HH