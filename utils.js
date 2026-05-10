// Shared utility functions for file I/O and data manipulation

import Gio from 'gi://Gio';

const decoder = new TextDecoder();

// Load and parse a JSON file, returns undefined on failure
export function loadJSON(path) {
    const file = Gio.File.new_for_path(path);
    if (!file.query_exists(null)) return undefined;

    try {
        const size = file.query_info(
            'standard::size', Gio.FileQueryInfoFlags.NONE, null
        ).get_size();
        const data = file.read(null).read_bytes(size, null).get_data();
        return JSON.parse(data instanceof Uint8Array ? decoder.decode(data) : data.toString());
    } catch (e) {
        console.error(`Error loading ${path}: ${e.message}`);
        return undefined;
    }
}

// Deep merge sources into target, mutates target
export function deepMerge(target, ...sources) {
    if (typeof target !== 'object' || target === null) return target;

    for (const source of sources) {
        if (typeof source !== 'object' || source === null) continue;
        for (const key of Object.keys(source)) {
            if (typeof target[key] === 'object' && typeof source[key] === 'object') {
                deepMerge(target[key], source[key]);
            } else {
                target[key] = source[key];
            }
        }
    }
    return target;
}

// Read file content as string, returns null on failure
export function readFileContent(path) {
    const file = Gio.File.new_for_path(path);
    if (!file.query_exists(null)) return null;

    try {
        const size = file.query_info(
            'standard::size', Gio.FileQueryInfoFlags.NONE, null
        ).get_size();
        const stream = file.open_readwrite(null).get_input_stream();
        const data = stream.read_bytes(size, null).get_data();
        stream.close(null);
        return data instanceof Uint8Array ? decoder.decode(data) : data.toString();
    } catch {
        return null;
    }
}
