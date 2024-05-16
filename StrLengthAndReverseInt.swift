import Foundation

// Function to read input from a file
func readInput(from filePath: String) -> String? {
    do {
        // Try to read the contents of the file at the given path as a string
        let inputString = try String(contentsOfFile: filePath)
        return inputString
    } catch {
        // Print an error message if reading the file fails
        print("Error reading input file: \(error)")
        return nil
    }
}

// Function to write output to a file
func writeOutput(to filePath: String, content: String) {
    // Attempt to create an output stream to the specified file
    guard let outputStream = OutputStream(toFileAtPath: filePath, append: false) else {
        print("Failed to open output file.")
        return
    }
    outputStream.open()
    defer {
        // Ensure the output stream is closed when done
        outputStream.close()
    }

    // Convert the content string to a buffer of UTF-8 bytes
    let buffer = Array(content.utf8)
    // Write the buffer to the output stream
    let bytesWritten = outputStream.write(buffer, maxLength: buffer.count)
    if bytesWritten < 0 {
        // Print an error message if writing to the file fails
        print("Error writing to output file.")
    }
}

// Recursive function to reverse an integer
func reverseInt(_ number: Int) -> Int {
    return reverseHelper(number, 0)
}

// Helper function to perform the actual reversal recursively
func reverseHelper(_ number: Int, _ reversed: Int) -> Int {
    if number == 0 {
        return reversed
    } else {
        // Continue the recursive process by taking the last digit of the current number
        // and adding it to the reversed number, then reducing the current number
        return reverseHelper(number / 10, reversed * 10 + number % 10)
    }
}

// Recursive function to calculate the length of a string
func stringLength(_ string: String) -> Int {
    if string.isEmpty {
        return 0
    } else {
        // Remove the first character and add 1 to the length calculated from the rest of the string
        return 1 + stringLength(String(string.dropFirst()))
    }
}

// Process the file based on user choice
func processFile(inputPath: String, outputPath: String) {
    // Read the input file contents
    guard let input = readInput(from: inputPath) else {
        fatalError("Failed to read from input file at \(inputPath)")
    }

    // Split the input into lines
    let lines = input.components(separatedBy: .newlines)
    var output = ""

    // Prompt the user to choose an operation
    print("Choose an operation:\n1: Reverse Integer\n2: Find String Length")
    if let choice = Int(readLine() ?? "0"), choice == 1 || choice == 2 {
        // Process each line based on the chosen operation
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedLine.isEmpty {
                continue
            }

            switch choice {
            case 1:
                // Option 1: Reverse Integer
                if let number = Int(trimmedLine), number > 0 {
                    let reversedNumber = reverseInt(number)
                    output += "Original Int: \(trimmedLine), Reversed Int: \(reversedNumber)\n"
                } else {
                    output += "Invalid input: \(trimmedLine) is not a positive integer.\n"
                }
            case 2:
                // Option 2: Find String Length
                let length = stringLength(trimmedLine)
                output += "Input String: \(trimmedLine), String Length: \(length)\n"
            default:
                print("Invalid choice.")
                return
            }
        }
    } else {
        // Print an error message if the user input is invalid
        print("Invalid input. Please enter 1 or 2.")
        return
    }

    // Write the processed output to the specified file
    writeOutput(to: outputPath, content: output)
}

// Example file paths
let inputFilePath = "./input.txt"
let outputFilePath = "./output.txt"

// Processing the file
processFile(inputPath: inputFilePath, outputPath: outputFilePath)
