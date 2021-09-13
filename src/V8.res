@module("v8")
external cachedDataVersionTag: unit => int = "cachedDataVersion"

type heapSpaceStats = {
  @as("space_name")
  space_name: string,
  @as("space_size")
  space_size: int,
  @as("space_used_size")
  space_used_size: int,
  @as("space_available_size")
  space_available_size: int,
  @as("space_physical_size")
  space_physical_size: int,
}

@module("v8")
external getHeapSpaceStatistics: unit => array<heapSpaceStats> = "getHeapSpaceStatistics"

@module("v8")
external getHeapSnapshot: unit => Stream.Readable.t<Buffer.t> = "getHeapSnapshot"

type heapStats = {
  @as("total_heap_size_executable")
  total_heap_size_executable: int,
  @as("total_physical_size")
  total_physical_size: int,
  @as("total_available_size")
  total_available_size: int,
  @as("used_heap_space")
  used_heap_space: int,
  @as("heap_size_limit")
  heap_size_limit: int,
  @as("malloced_memory")
  malloced_memory: int,
  @as("peak_malloced_memory")
  peak_malloced_memory: int,
  @as("does_zap_garbage")
  does_zap_garbage: int,
  @as("number_of_native_contexts")
  number_of_native_contexts: int,
  @as("number_of_detached_contexts")
  number_of_detached_contexts: int,
}

@module("v8")
external getHeapStatistics: unit => heapStats = "getHeapStatistics"

type heapCodeStats = {
  @as("code_and_metadata_size")
  code_and_metadata_size: int,
  @as("bytecode_and_metadata_size")
  bytecode_and_metadata_size: int,
  @as("external_script_source_size")
  external_script_source_size: int,
}

@module("v8")
external getHeapCodeStatistics: unit => heapStats = "getHeapCodeStatistics"

@module("v8")
external writeHeapSnapshot: string => Js.Json.t = "writeHeapSnapshot"

@module("v8") external serialize: 'a => Buffer.t = "serialize"
@module("v8") external deserialize: Buffer.t => 'a = "deserialize"
