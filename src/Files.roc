module [
    serveCssFile!,
    serveIconsCssFile!,
    serveImageFile!,
]

import pf.Http exposing [Response]
import pf.File

# Files.roc
# File serving functionality for static assets

# Helper function to serve CSS file
serveCssFile! : {} => Result Response [ServerErr Str]
serveCssFile! = |_|
    cssResult = File.read_utf8!("static/css/output.css")
    
    when cssResult is
        Ok(css) ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/css"},
                        {name: "Cache-Control", value: "public, max-age=31536000, immutable"},
                        {name: "ETag", value: "\"css-v1\""},
                        {name: "Vary", value: "Accept-Encoding"}
                    ],
                    body: Str.to_utf8(css),
                },
            )
        Err(_) ->
            Ok(
                {
                    status: 500,
                    headers: [{name: "Content-Type", value: "text/plain"}],
                    body: Str.to_utf8("Internal Server Error: Could not load CSS file"),
                },
            )

# Helper function to serve icons CSS file
serveIconsCssFile! : {} => Result Response [ServerErr Str]
serveIconsCssFile! = |_|
    cssResult = File.read_utf8!("static/css/icons.css")
    
    when cssResult is
        Ok(css) ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/css"},
                        {name: "Cache-Control", value: "public, max-age=31536000, immutable"},
                        {name: "ETag", value: "\"icons-css-v1\""},
                        {name: "Vary", value: "Accept-Encoding"}
                    ],
                    body: Str.to_utf8(css),
                },
            )
        Err(_) ->
            Ok(
                {
                    status: 500,
                    headers: [{name: "Content-Type", value: "text/plain"}],
                    body: Str.to_utf8("Internal Server Error: Could not load icons CSS file"),
                },
            )

# Helper function to serve image files as binary data
serveImageFile! : Str, Str => Result Response [ServerErr Str]
serveImageFile! = |filePath, mimeType|
    # Read the image file as binary data
    imageResult = File.read_bytes!(filePath)
    
    when imageResult is
        Ok(imageBytes) ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: mimeType},
                        {name: "Cache-Control", value: "public, max-age=31536000, immutable"},
                        {name: "ETag", value: "\"img-v1\""},
                        {name: "Vary", value: "Accept-Encoding"}
                    ],
                    body: imageBytes,
                },
            )
        Err(_) ->
            Ok(
                {
                    status: 404,
                    headers: [],
                    body: Str.to_utf8("Image not found"),
                },
            )
