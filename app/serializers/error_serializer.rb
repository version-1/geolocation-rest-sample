class ErrorSerializer < ActiveModelSerializers::Model
  attributes :id, :status, :code, :title, :links, :detail, :source, :meta

  class << self
    def not_found(_e)
      new(
        id: SecureRandom.uuid,
        status: 404,
        code: 'not_found',
        title: 'Resource not found',
        detail: 'The requested resource could not be found',
      )
    end

    def record_invalid(e)
      new(
        id: SecureRandom.uuid,
        status: 400,
        code: 'record_invalid',
        title: 'Record invalid',
        detail: _e.record.errors.full_messages.join(', ')
      )
    end

    def internal_server_error(e)
      new(
        id: SecureRandom.uuid,
        status: 500,
        code: 'internal_server_error',
        title: 'Internal server error',
        detail: 'Unexpected error occurred. Please try again later or reposrt system administrator.'
      )
    end
  end
end
