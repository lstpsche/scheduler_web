const defaultArgs = {
  onSuccess: (response) => { return response },
  onFailure: (error) => { throw new Error(error) },
  errorMessage: I18n.t("errors.internal_server_error")
}

function fetchLink (args) {
  if (args.method === "GET" || args.method === undefined)
    return fetchGet(args);
  else
    return fetchWithBody(args);
}

function filterResponseCode (response, errorMessage) {
  if (response.status === 200)
    return response.json();
  if (response.status === 204)
    return response;

  throw new Error(errorMessage);
}

const headers = {
  "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
  "Content-Type": "application/json"
}

function fetchGet ({
    link,
    onSuccess = defaultArgs.onSuccess,
    onFailure = defaultArgs.onFailure,
    errorMessage = defaultArgs.errorMessage
  }) {
  return fetch(link, { headers })
    .then(response => filterResponseCode(response, errorMessage))
    .then(response => onSuccess(response))
    .catch(error => onFailure(error))
}

function fetchWithBody ({
    link, method, body = "",
    onSuccess = defaultArgs.onSuccess,
    onFailure = defaultArgs.onFailure,
    errorMessage = defaultArgs.errorMessage
  }) {
  return fetch(link, { headers, method, body })
    .then(response => filterResponseCode(response, errorMessage))
    .then(response => onSuccess(response))
    .catch(error => onFailure(error))
}

export default fetchLink;
