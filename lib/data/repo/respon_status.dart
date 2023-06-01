Map<int?, String> rStatusCreate = {
  201: "Created",
  304: "Not modified",
  403: "Forbidden",
  404: "Resource not found",
  422: "Validation failed, or the endpoint has been spammed.",
  null: "Exception"
};

Map<int?, String> rStatusUpdateGist = {
  200: "Ok",
  404: "Resource not found",
  422: "Validation failed, or the end ponint has been spammed",
  null: "Exception"
};

Map<int?, String> rStatusDeleteGist = {
  204: "No Content",
  304: "Not modified",
  403: "Forbidden",
  404: "Resource not found",
  null: "Exception"
};
