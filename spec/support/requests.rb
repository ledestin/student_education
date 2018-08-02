shared_context :json do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:json_body) { JSON.parse response.body }
  let(:json_errors) { json_body["errors"] }
end
