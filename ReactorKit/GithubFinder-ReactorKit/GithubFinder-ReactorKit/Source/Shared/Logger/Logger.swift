//
//  Logger.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/17/24.
//

import Foundation
import os.log

import Then

private class LogFormatter {
    static let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    static func format(level: String, fileName: String, function: String, line: Int, message: String) -> String {
        let timestamp = dateFormatter.string(from: Date())
        return "\(timestamp) \(level) \(fileName).\(function):\(line) - \(message)"
    }
}

/// A shared instance of `Logger`
let log = Logger()

actor Logger {
    private let logFileURL: URL
    
    // MARK: - Initialize
    init() {
        let fileManager = FileManager.default
        let logsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Logs")
        
        if !fileManager.fileExists(atPath: logsDirectory.path) {
            try? fileManager.createDirectory(at: logsDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        logFileURL = logsDirectory.appendingPathComponent("log.txt")
        Task { await rotateLogFiles() }
    }
    
    // MARK: - Public Logging Methods
    func error(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "❤️ ERROR", items: items, file: file, function: function, line: line)
    }
    
    func warning(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "💛 WARNING", items: items, file: file, function: function, line: line)
    }
    
    func info(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "💙 INFO", items: items, file: file, function: function, line: line)
    }
    
    func debug(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "💚 DEBUG", items: items, file: file, function: function, line: line)
    }
    
    func verbose(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "💜 VERBOSE", items: items, file: file, function: function, line: line)
    }
    
    func APICall(_ items: Any..., file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        logWithoutAwait(level: "📡 APICall", items: items, file: file, function: function, line: line)
    }
    
    // MARK: - Private Methods
    
    private func logWithoutAwait(level: String, items: [Any], file: StaticString, function: StaticString, line: UInt) {
        Task { await log(level: level, items: items, file: file, function: function, line: line) }
    }
    
    private func log(level: String, items: [Any], file: StaticString, function: StaticString, line: UInt) async {
        #if DEBUG
        let message = message(from: items)
        let formattedMessage = LogFormatter.format(level: level, fileName: "\(file)", function: "\(function)", line: Int(line), message: message)
        print(formattedMessage)
        await writeToFile(message: formattedMessage)
        #endif
    }
    
    private func message(from items: [Any]) -> String {
        return items.map { String(describing: $0) }.joined(separator: " ")
    }
    
    private func writeToFile(message: String) async {
        let messageWithNewline = message + "\n"
        guard let data = messageWithNewline.data(using: .utf8) else { return }
        
        do {
            if FileManager.default.fileExists(atPath: logFileURL.path) {
                let fileHandle = try FileHandle(forWritingTo: logFileURL)
                try fileHandle.seekToEnd()
                try fileHandle.write(contentsOf: data)
                try fileHandle.close()
            } else {
                try data.write(to: logFileURL)
            }
        } catch {
            print("❌ Failed to write log to file: \(error)")
        }
    }
    
    private func rotateLogFiles() async {
        let fileManager = FileManager.default
        let logsDirectory = logFileURL.deletingLastPathComponent()
        
        let logFiles = (try? fileManager.contentsOfDirectory(at: logsDirectory, includingPropertiesForKeys: [.creationDateKey], options: .skipsHiddenFiles)) ?? []
        let logFileLimit = 7
        
        if logFiles.count >= logFileLimit {
            let sortedLogFiles = logFiles.sorted { file1, file2 in
                let date1 = (try? file1.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? Date()
                let date2 = (try? file2.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? Date()
                return date1 < date2
            }
            for logFile in sortedLogFiles.prefix(logFiles.count - logFileLimit + 1) {
                try? fileManager.removeItem(at: logFile)
            }
        }
    }
}
